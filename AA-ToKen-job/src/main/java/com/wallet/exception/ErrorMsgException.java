package com.wallet.exception;

public class ErrorMsgException extends Exception {
	private static final long serialVersionUID = 1L;

	public ErrorMsgException(int errorcode) {
		super(errorcode + "");
	}
	public ErrorMsgException(String message, Throwable cause) {
		super(message, cause);
	}

}
