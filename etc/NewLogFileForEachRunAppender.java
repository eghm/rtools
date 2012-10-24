package com.veerasundar.dynamiclogger;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;

import org.apache.log4j.FileAppender;
import org.apache.log4j.Layout;
import org.apache.log4j.spi.ErrorCode;

/**
 * This is a customized log4j appender, which will create a new file for every
 * run of the application.
 * 
 * @author veera | http://veerasundar.com/blog/2009/08/how-to-create-a-new-log-file-for-each-time-the-application-runs/
 * 
 */
public class NewLogFileForEachRunAppender extends FileAppender {

	public final static String DTS_DEFAULT_FORMAT = "yyyyMMddHHmmssSSS";
	public final static String DTS_FORMAT_PROPERTY = "dts.format";
	public final static String DTS_LOG_FILENAME_PROPERTY = "dts.log.filename";
	
	private SimpleDateFormat simpleDateFormat;

	public NewLogFileForEachRunAppender() {
	}

	public NewLogFileForEachRunAppender(Layout layout, String filename,
			boolean append, boolean bufferedIO, int bufferSize)
			throws IOException {
		super(layout, filename, append, bufferedIO, bufferSize);
	}

	public NewLogFileForEachRunAppender(Layout layout, String filename,
			boolean append) throws IOException {
		super(layout, filename, append);
	}

	public NewLogFileForEachRunAppender(Layout layout, String filename)
			throws IOException {
		super(layout, filename);
	}

	public void activateOptions() {
		if (fileName != null) {
			try {
				fileName = getNewLogFileName();
				setFile(fileName, fileAppend, bufferedIO, bufferSize);
			} catch (Exception e) {
				errorHandler.error("Error while activating log options", e,
						ErrorCode.FILE_OPEN_FAILURE);
			}
		}
	}

	private String getNewLogFileName() {
		if (fileName != null) {
			if (simpleDateFormat == null) {
				simpleDateFormat = new SimpleDateFormat(System.getProperty(DTS_FORMAT_PROPERTY, DTS_DEFAULT_FORMAT));
			}
			final String DOT = ".";
			final String HIPHEN = "-";
			final File logFile = new File(fileName);
			final String fileName = logFile.getName();
			String newFileName = "";
			String propertyFileName = System.getProperty(DTS_LOG_FILENAME_PROPERTY, fileName);
			String testName = System.getProperty("it.test", "");
			if (!"".equals(testName)) {
				testName = testName + HIPHEN;
			}

			final int dotIndex = propertyFileName.indexOf(DOT);
			if (dotIndex != -1) {
				// the file name has an extension. so, insert the time stamp
				// between the file name and the extension
				newFileName = propertyFileName.substring(0, dotIndex) + HIPHEN
						+ testName + simpleDateFormat.format(System.currentTimeMillis()) + DOT
						+ propertyFileName.substring(dotIndex + 1);
			} else {
				// the file name has no extension. So, just append the timestamp
				// at the end.
				newFileName = propertyFileName + HIPHEN + testName + simpleDateFormat.format(System.currentTimeMillis());
			}
			return logFile.getParent() + File.separator + newFileName;
		}
		return null;
	}
}