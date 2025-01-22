using Toybox.Activity as Act;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;

class DiscardConfirmationDelegate extends Ui.ConfirmationDelegate
{
    hidden var _option;

    function initialize(option) {
        ConfirmationDelegate.initialize();
        _option = option;
    }

    function onResponse(response) {
        if (response == CONFIRM_YES) {
            // discard the session here
            App.getApp().discardActivity();

            // pop the main view
            Ui.popView(Ui.SLIDE_IMMEDIATE);
            //Ui.requestUpdate();
        }
        else {
            var menu = new SaveMenu(_option);
            var delegate = new SaveMenuDelegate(_option);
            Ui.pushView(menu, delegate, Ui.SLIDE_IMMEDIATE);
        }

        return true;
    }
}

class DiscardConfirmation extends Ui.Confirmation
{
    function initialize() {
        Confirmation.initialize("Discard?");
    }
}

class SmartProgressBar extends Ui.ProgressBar
{
    hidden var _timer;
    hidden var _ticks;
    hidden var _text;

    function initialize(start, finish) {
        ProgressBar.initialize(start, null);

        _timer = new Timer.Timer();
        _timer.start(self.method(:onTimer), 1000, true);

        _ticks = 0;
        _text = finish;
    }

    function onTimer() as Void {
        _ticks += 1;
        if (_ticks == 2) {
            setDisplayString(_text);
            setProgress(100.0);
        }
        else if (_ticks == 3) {
            _timer.stop();
            _timer = null;

            // pop the progress bar
            Ui.popView(Ui.SLIDE_IMMEDIATE);

            // pop the main view
            Ui.popView(Ui.SLIDE_IMMEDIATE);
        }
    }
}

class SaveProgressBarDelegate extends Ui.BehaviorDelegate
{
    function initialize() {
        BehaviorDelegate.initialize();
    }

    // do nothing!
}

class SaveProgressBar extends SmartProgressBar
{
    function initialize() {
        SmartProgressBar.initialize("Saving", "Activity Saved");
    }
}

class SaveMenuDelegate extends Ui.MenuInputDelegate
{
    hidden var _option;

    function initialize(option) {
        MenuInputDelegate.initialize();
        _option = option;
    }

    function onMenuItem(item) as Void {
        if (item == :save) {
            // save session here
            App.getApp().saveActivity();
            var view = new SaveProgressBar();
            var delegate = new SaveProgressBarDelegate();

            // pop the save menu
            Ui.popView(Ui.SLIDE_IMMEDIATE);

            // push the progress bar
            Ui.pushView(view, delegate, Ui.SLIDE_IMMEDIATE);
        }
        else if (item == :discard) {
            var view = new DiscardConfirmation();
            var delegate = new DiscardConfirmationDelegate(_option);

            // pop the save menu
            Ui.popView(Ui.SLIDE_IMMEDIATE);

            // push the confirmation
            Ui.pushView(view, delegate, Ui.SLIDE_IMMEDIATE);
        }
        else if (item == :resume) {
            App.getApp().startActivity();
        }
    }
}

enum {
    OPTION_SAVE                 = 0x01,
    OPTIONS_SAVE_DISCARD        = 0x03,
    OPTIONS_SAVE_RESUME         = 0x05,
    OPTION_DISCARD              = 0x02,
    OPTION_RESUME               = 0x04,
    OPTIONS_DISCARD_RESUME      = 0x06,
    OPTIONS_SAVE_RESUME_DISCARD = 0x07
}


class SaveMenu extends Ui.Menu
{
    function initialize(option) {
        Menu.initialize();

        if (option & OPTION_RESUME) {
            Menu.addItem("Resume" , :resume);
        }

        if (option & OPTION_DISCARD) {
            Menu.addItem("Save"   , :save);
        }

        if (option & OPTION_DISCARD) {
            Menu.addItem("Discard", :discard);
        }
    }
}
