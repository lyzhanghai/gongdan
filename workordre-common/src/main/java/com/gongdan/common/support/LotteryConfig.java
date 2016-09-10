package com.gongdan.common.support;

import java.util.List;

import org.springframework.util.Assert;

/**
 * 抽奖配置
 * 
 * @param <T>
 * @author  pengpeng
 * @date 	 2016年4月19日 下午2:19:16
 * @version 1.0
 */
public class LotteryConfig<T> {
	
	/** 整体中奖概率 */
	private final double globalProbability;
	
	/** 已排过序的抽奖对象列表 */
	private final List<Lottery<T>> lotteryObjList;

	public LotteryConfig(double globalProbability,
			List<Lottery<T>> lotteryObjList) {
		super();
		Assert.isTrue(globalProbability >= 0 && globalProbability <= 1, "整体中奖概率'globalProbability'的值必须在[0,1]之间!");
		Assert.notEmpty(lotteryObjList, "抽奖对象列表'lotteryObjList'不能为空!");
		this.globalProbability = globalProbability;
		this.lotteryObjList = lotteryObjList;
	}

	public double getGlobalProbability() {
		return globalProbability;
	}

	public List<Lottery<T>> getLotteryObjList() {
		return lotteryObjList;
	}
	
}