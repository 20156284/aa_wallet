package com.wallet.job.benum;

public enum protocolType {
	ERC20("以太坊"),
	TRC20("波场"),
	FIL("Filecoin");
	protected final String name;

	private protocolType(String name) {
		this.name = name;
	}

	/**
	 * 获取中文名称.
	 * 
	 * @return {@link String}
	 */
	public String getName() {
		return name;
	}
}
