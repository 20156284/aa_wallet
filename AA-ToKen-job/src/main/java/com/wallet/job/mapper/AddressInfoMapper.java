package com.wallet.job.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
}