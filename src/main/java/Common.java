/**
 * Created by macking on 14-8-25.
 */

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Common {
    private static final Pattern _paramRegexFirst = Pattern.compile("^\\s*(\\w[\\w\\d\\._]*)\\s*=");
    private static final Pattern _paramRegexSecond = Pattern.compile(",\\s*(\\w[\\w\\d\\._]*)\\s*=");

    /**
     * Extract name/value pairs from given input string
     * The key name is constrained to be: must start with letter and can only include
     * letters, numbers,dot,underscore.
     *
     * @param str the parameters name,value pairs string, comma separated
     * @return map of the name/value extracted from the inputs, null if not found valid pairs
     */
    public static Map<String, String> parseMapStr(String str) {
        if (str != null) {
            try {
                Map<String, String> map = new HashMap<String, String>();
                Matcher matc = _paramRegexFirst.matcher(str);
                String sName = "";
                int curStart = 0;
                int curEnd = 0;
                int prevEnd = 0;
                boolean bMatched = false;
                if (matc.find()) {
                    bMatched = true;
                    curEnd = matc.end();
                    prevEnd = curEnd;
                    sName = matc.group(1).trim();

                    //continue to find the other parameters
                    Matcher matc2 = _paramRegexSecond.matcher(str);
                    while (matc2.find()) {
                        bMatched = true;
                        curStart = matc2.start();
                        curEnd = matc2.end();
                        if (sName.length() != 0) {
                            map.put(sName, str.substring(prevEnd, curStart).trim());
                        }
                        prevEnd = curEnd;
                        sName = matc2.group(1).trim();
                    }
                    //get and set the value of the last matched parameter
                    if (sName.length() != 0) {
                        map.put(sName, str.substring(prevEnd, str.length()).trim());
                    }
                }

                return bMatched ? map : null;

            } catch (Exception e) {
                System.out.println("Exception:" + e.getMessage());
            }
        }
        return null;
    }
}
