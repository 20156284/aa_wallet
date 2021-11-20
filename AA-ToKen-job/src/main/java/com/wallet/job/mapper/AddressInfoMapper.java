package com.wallet.job.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface AddressInfoMapper {
    /**
     * @description: 添加地址信息
     * @return:
     * @author: huoche
     * @time: 2021/7/19 18:01
     */
    void addAddress(@Param("address") String address,
                    @Param("protocol") String protocol);


    /**
     * @description: 判断地址是否存在
     * @return:
     * @author: huoche
     * @time: 2021/11/19 10:30
     */
    Integer getAddressCount(@Param("address") String address,
                            @Param("protocol") String protocol);

    /**
     * @description: 修改地状态
     * @return:
     * @author: huoche
     * @time: 2021/11/19 10:32
     */
    void updateAddress(@Param("protocol") String protocol,
                       @Param("id") Integer id);

    /**
     * @description: 删除地址
     * @return:
     * @author: huoche
     * @time: 2021/11/19 10:30
     */
    void deleteAddress(@Param("address") String address,
                       @Param("protocol") String protocol);

    /**
     * @description: 转账记录
     * @return: type 10 转入；20：转出;
     * @author: huoche
     * @time: 2021/11/19 11:45
     */
    List<Map<Object, String>> transactionRecords(@Param("type") String type,
                                                 @Param("address") String address,
                                                 @Param("protocol") String protocol);
}