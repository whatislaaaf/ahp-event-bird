package app.adhdhyperplanner.eventbird;

import com.getcapacitor.Logger;

public class AhpEventBird {

    public String echo(String value) {
        Logger.info("Echo", value);
        return value;
    }
}
