package com.xxxx.common.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParsePosition;

public class BigDecimalUtil {
    private final static DecimalFormat format = new DecimalFormat();
    private final static ParsePosition position = new ParsePosition(0);

    public static BigDecimal parseValue(String str) {
        format.setParseBigDecimal(true);
        return (BigDecimal) format.parse(str, position);
    }
}