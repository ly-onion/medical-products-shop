package com.xxxx.common.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
 
/**
 * 时间转化工具 date转为时间戳 时间戳转date 互相与String的转换
 * 所有出现的String time 格式都必须为(yyyy-MM-dd HH:mm:ss)，否则出错
 * @author 赵仁杰
 * 
 */
public class TimeExchange {
 
	/**
	 * String(yyyy-MM-dd HH:mm:ss) 转 Date
	 * 
	 * @param time
	 * @return
	 * @throws ParseException
	 */
	// String date = "2010/05/04 12:34:23";
	public static Date StringToDate(String time) throws ParseException {
		
		Date date = new Date();
		// 注意format的格式要与日期String的格式相匹配
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			date = dateFormat.parse(time);
			System.out.println(date.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
 
		return date;
	}
 
	/**
	 * Date转为String(yyyy-MM-dd HH:mm:ss)
	 * 
	 * @param time
	 * @return
	 */
	public static String DateToString(Date time) {
		String dateStr = "";
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH/mm/ss");
		try {
			dateStr = dateFormat.format(time);
			System.out.println(dateStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dateStr;
	}
	/**
	 * String(yyyy-MM-dd HH:mm:ss)转10位时间戳
	 * @param time
	 * @return
	 */
	public static Integer StringToTimestamp(String time){

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return Math.toIntExact(dateFormat.parse(time).getTime()/1000);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return 0;

	}
	/**
	 * 10位int型的时间戳转换为String(yyyy-MM-dd HH:mm:ss)
	 * @param time
	 * @return
	 */
	public static String timestampToString(Integer time){
		//int转long时，先进行转型再进行计算，否则会是计算结束后在转型
		long temp = (long)time*1000;
		Timestamp ts = new Timestamp(temp);  
        String tsStr = "";  
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {  
            //方法一  
            tsStr = dateFormat.format(ts);
        } catch (Exception e) {  
            e.printStackTrace();  
        }
		return tsStr;  
	}
	/**
	 * 10位时间戳转Date
	 * @param time
	 * @return
	 */
	public static Date TimestampToDate(Integer time){
		long temp = (long)time*1000;
		Timestamp ts = new Timestamp(temp);  
        Date date = new Date();  
        try {  
            date = ts;  
            //System.out.println(date);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return date;
	}
	/**
	 * Date类型转换为10位时间戳
	 * @param time
	 * @return
	 */
	public static Integer DateToTimestamp(Date time){
		Timestamp ts = new Timestamp(time.getTime());
		
		return (int) ((ts.getTime())/1000);
	}

	public static void main(String[] args) throws ParseException {
//		StringToTimestamp("2021-05-06"+" 00:00:00");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println((dateFormat.parse("2021-05-06").getTime())/1000);
	}
}
