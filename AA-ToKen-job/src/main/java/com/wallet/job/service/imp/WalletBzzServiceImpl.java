package com.wallet.job.service.imp;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wallet.job.entity.Bo.BzzDataCenter;
import com.wallet.job.entity.Bo.BzzPeers;
import com.wallet.job.entity.Bo.BzzPrice;
import com.wallet.job.entity.WalletBzz;
import com.wallet.job.entity.WalletBzzNode;
import com.wallet.job.mapper.WalletBzzMapper;
import com.wallet.job.mapper.WalletBzzNodeMapper;
import com.wallet.job.service.WalletBzzService;
import com.wallet.job.util.eth.NodeUtil;
import com.wallet.job.util.eth.XdaiUtil;
import com.wallet.job.util.trx.TrxUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.web3j.crypto.Credentials;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class WalletBzzServiceImpl implements WalletBzzService {
    private static Logger logger = LoggerFactory.getLogger(WalletBzzServiceImpl.class);
    @Autowired
    private WalletBzzMapper walletBzzMapper;
    @Autowired
    private WalletBzzNodeMapper walletBzzNodeMapper;
    @Autowired
    private TrxUtil trxUtil;
    @Value("${bzz.price.url}")
    private String bzzPriceUrl;
    @Value("${bzz.node.url}")
    private String bzzNodeUrl;

    @Override
    public PageInfo<WalletBzz> getPageList(WalletBzz walletBzz, int pageNo, int pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<WalletBzz> listsBzz = walletBzzMapper.selectList(walletBzz);
        List<WalletBzz> listsWalletBzz = new ArrayList<>();
        WalletBzz bzz = null;
        if (listsBzz != null && listsBzz.size() > 0) {
            for (WalletBzz bzzs : listsBzz) {
                bzz = new WalletBzz();
                BeanUtils.copyProperties(bzzs, bzz);
                if (bzzs.getNodeName().length() > 4) {
                    bzz.setNodeName(bzzs.getNodeName()
                            .substring(0, 3) + "***" + bzzs.getNodeName()
                            .substring(bzzs.getNodeName().length() - 3, bzzs.getNodeName().length()));
                    bzz.setNodeAddress(null);
                }
                bzz.setNoAgainstBzz(new BigDecimal(bzz.getNoAgainstBzz().stripTrailingZeros().toPlainString()));
                listsWalletBzz.add(bzz);
            }
        }
        return new PageInfo<WalletBzz>(listsWalletBzz);

    }

    @Override
    public List<WalletBzzNode> selectList(WalletBzzNode walletBzzNode) {
        return walletBzzNodeMapper.selectList(walletBzzNode);
    }

    @Override
    public List<BzzDataCenter> dataCentre(WalletBzz walletBzz) {
        List<Map<String, Object>> lists = walletBzzMapper.dataCentreMap(walletBzz);
        List<BzzDataCenter> listBzzDataCenter = new ArrayList<>();
        if (lists != null && lists.size() > 0) {
            for (Map<String, Object> m : lists) {
                BzzDataCenter bzz = new BzzDataCenter();
                bzz.setName(m.get("name").toString());
                bzz.setValue(Integer.parseInt(m.get("number").toString()));
                listBzzDataCenter.add(bzz);
            }
        }
        return listBzzDataCenter;
    }

    @Override
    public List<BzzPrice> bzzPrice() {
        String strDateFormat = "HH:mm:ss";
        SimpleDateFormat sdf = new SimpleDateFormat(strDateFormat);
        List<Map<String, Object>> lists = walletBzzMapper.bzzPrice();
        List<BzzPrice> listBzzPrice = new ArrayList<>();
        if (lists != null && lists.size() > 0) {
            for (Map<String, Object> m : lists) {
                BzzPrice bzz = new BzzPrice();
                bzz.setDate(sdf.format(m.get("date")));
                bzz.setPrice(m.get("price").toString());
                listBzzPrice.add(bzz);
            }
        }
        return listBzzPrice;
    }

    @Override
    public List<BzzPeers> bzzPeers() {
        return walletBzzMapper.bzzPeers();
    }

    @Override
    public void getBzzPrice() {
        try {
            JSONObject json = trxUtil.sendHttpGet(bzzPriceUrl);
            logger.warn("BZZ价格返回信息:{}", json);
            if (json != null) {
                JSONArray jsonArray = JSON.parseArray(json.get("data").toString());
                if (jsonArray != null && jsonArray.size() > 0) {
                    for (int i = 0; i < jsonArray.size(); i++) {
                        String data = jsonArray.get(i).toString().replace("[", "").replace("]", "");
                        int count = walletBzzMapper.getCountPrice(data);
                        if (count == 0) {
                            walletBzzMapper.addBzzPrice(data);
                        }

                    }

                }
//
            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.warn("BZZ价格异常:{}", e.getMessage());
        }

    }

    @Override
    public void updateBzzData(String appId) {
        try {
            //拿到数据
            String result = trxUtil.sendHttpGetBzzscan(bzzNodeUrl);
            logger.warn("BZZ节点返回数据:{}", JSONObject.parseObject(result));
            if (result != null) {
                JSONObject summary = JSONObject.parseObject(result);
                JSONObject activeNode = JSONObject.parseObject(summary.getString("summary"));
                Integer beenodesAll = activeNode.getInteger("beenodes_all");//全网节点数（含历史节点）
                Integer beenodesLive = activeNode.getInteger("beenodes_live");// 全网活跃节点数
                Integer beenodesAa = walletBzzMapper.getCountBeenodesAa(appId);
                int id = walletBzzMapper.getByid(appId);
                //如果数据为空就插入进入
                if (id == 0) {
                    walletBzzMapper.addNode(appId, beenodesAll, beenodesLive, beenodesAa);
                } else {
                    walletBzzMapper.updateNode(id, beenodesAll, beenodesLive, beenodesAa);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.warn("BZZ节点数量异常:{}", e.getMessage());
        }
    }

    @Override
    public void updatePeers(String appId) {
        WalletBzz walletBzz = new WalletBzz();
        walletBzz.setAppId(appId);
        List<WalletBzz> listsBzz = walletBzzMapper.selectList(walletBzz);
        String result = null;
        if (listsBzz != null && listsBzz.size() > 0) {
            for (WalletBzz bzz : listsBzz) {
                WalletBzz wallet_Bzz = new WalletBzz();
                String ip = "http://" + bzz.getNodeName() + ":" + bzz.getDebugApiAddr();
                String stats = getStats(ip);
                if (StringUtils.isBlank(stats)) {
                    wallet_Bzz.setId(bzz.getId());
                    wallet_Bzz.setPeers(0);
                    walletBzzMapper.update(wallet_Bzz);
                    continue;
                }
                result = trxUtil.sendHttpGetBzzscan(ip + "/peers");
                JSONObject peers = JSON.parseObject(result);
                JSONArray jsonArray = JSON.parseArray(peers.get("peers").toString());
                wallet_Bzz.setId(bzz.getId());
                wallet_Bzz.setPeers(jsonArray.size());
                logger.warn("BZZ-Peers返回信息:{},id:{}", jsonArray.size(), bzz.getId());
                walletBzzMapper.update(wallet_Bzz);
            }
        }
    }

    @Override
    public void updateBzzStats(String appId) {
        WalletBzz walletBzz = new WalletBzz();
        walletBzz.setAppId(appId);
        List<WalletBzz> listsBzz = walletBzzMapper.selectList(walletBzz);
        String result = null;
        if (listsBzz != null && listsBzz.size() > 0) {
            for (WalletBzz bzz : listsBzz) {
                String ip = "http://" + bzz.getNodeName() + ":" + bzz.getDebugApiAddr();
                //状态
                result = trxUtil.sendHttpGetBzzscan(ip + "/health");
                WalletBzz wallet_Bzz = new WalletBzz();
                if (StringUtils.isBlank(result) || StringUtils.isBlank(JSON.parseObject(result).getString("status"))) {
                    wallet_Bzz.setStatus(2);
                } else {
                    //状态
                    wallet_Bzz.setStatus(1);
                    wallet_Bzz.setVersion(JSON.parseObject(result).getString("version"));
                    //peers
                    result = trxUtil.sendHttpGetBzzscan(ip + "/peers");
                    JSONObject peers = JSON.parseObject(result);
                    JSONArray jsonArray = JSON.parseArray(peers.get("peers").toString());
                    wallet_Bzz.setPeers(jsonArray.size());
                    //出票
                    result = trxUtil.sendHttpGetBzzscan("http://" + bzz.getNodeName() + ":" + bzz.getDebugApiAddr() + "/chequebook/cheque");
                    if (StringUtils.isBlank(result)) {
                        continue;
                    }
                    JSONObject peers1 = JSON.parseObject(result);
                    List<Map<String, Object>> lastcheques = (List<Map<String, Object>>) JSONArray.parse(peers1.get("lastcheques").toString());
                    if (lastcheques != null || lastcheques.size() > 0) {
                        for (Map<String, Object> las : lastcheques) {
                            int count = walletBzzMapper.getPeer(las.get("peer").toString());
                            if (count == 0) {
                                int p = bzz.getNoTicket() + 1;
                                wallet_Bzz.setNoTicket(p);
                                walletBzzMapper.addPeerInfo(las.get("peer").toString(), bzz.getId());
                            }
                        }
                    }
                    logger.warn("BZZ-:{},返回信息,状态:{},peers:{},出票:{},id:{}", appId, JSON.parseObject(result), jsonArray.size(), result, bzz.getId());
                }
                wallet_Bzz.setId(bzz.getId());
                walletBzzMapper.update(wallet_Bzz);
            }

        }
    }

    @Override
    public void updateBzzInfoGy(String appId, int start, int stop) {
        WalletBzz walletBzz = new WalletBzz();
        walletBzz.setAppId(appId);
        List<WalletBzz> listsBzz = walletBzzMapper.selectListGy(appId, start, stop);
        String result = null;
        if (listsBzz != null && listsBzz.size() > 0) {
            for (WalletBzz bzz : listsBzz) {
                String ip = "http://" + bzz.getNodeName() + ":" + bzz.getDebugApiAddr();
                //状态
                result = trxUtil.sendHttpGetBzzscan(ip + "/health");
                WalletBzz wallet_Bzz = new WalletBzz();
                if (StringUtils.isBlank(result) || StringUtils.isBlank(JSON.parseObject(result).getString("status"))) {
                    wallet_Bzz.setStatus(2);
                } else {
                    //状态
                    wallet_Bzz.setStatus(1);
                    wallet_Bzz.setVersion(JSON.parseObject(result).getString("version"));
                    //peers
                    result = trxUtil.sendHttpGetBzzscan(ip + "/peers");
                    JSONObject peers = JSON.parseObject(result);
                    if (StringUtils.isBlank(result) || peers.get("peers") == null) {
                        continue;
                    }
                    JSONArray jsonArray = JSON.parseArray(peers.get("peers").toString());
                    wallet_Bzz.setPeers(jsonArray.size());
                    //出票
                    result = trxUtil.sendHttpGetBzzscan("http://" + bzz.getNodeName() + ":" + bzz.getDebugApiAddr() + "/chequebook/cheque");
                    if (StringUtils.isBlank(result)) {
                        continue;
                    }
                    JSONObject peers1 = JSON.parseObject(result);
                    List<Map<String, Object>> lastcheques = (List<Map<String, Object>>) JSONArray.parse(peers1.get("lastcheques").toString());
                    if (lastcheques != null || lastcheques.size() > 0) {
                        for (Map<String, Object> las : lastcheques) {
                            int count = walletBzzMapper.getPeer(las.get("peer").toString());
                            if (count == 0) {
                                int p = bzz.getNoTicket() + 1;
                                wallet_Bzz.setNoTicket(p);
                                walletBzzMapper.addPeerInfo(las.get("peer").toString(), bzz.getId());
                            }
                        }
                    }
                    logger.warn("BZZ-:{},返回信息,状态:{},peers:{},出票:{},id:{}", appId, JSON.parseObject(result), jsonArray.size(), result, bzz.getId());
                }
                wallet_Bzz.setId(bzz.getId());
                walletBzzMapper.update(wallet_Bzz);
            }

        }
    }

    @Override
    public void updateBzzInfo(String appId) {
        WalletBzz walletBzz = new WalletBzz();
        walletBzz.setAppId(appId);
        walletBzz.setXdaiBalance(BigDecimal.ZERO);
        //walletBzz.setId(19);
        List<WalletBzz> listsBzz = walletBzzMapper.selectList(walletBzz);
        String result = null;
        XdaiUtil xdaiUtil = new XdaiUtil();
        if (listsBzz != null && listsBzz.size() > 0) {
            for (WalletBzz bzz : listsBzz) {
                WalletBzz wallet_Bzz = new WalletBzz();
                String ip = "http://" + bzz.getNodeName() + ":" + bzz.getDebugApiAddr();
                String stats = getStats(ip);
                logger.warn("BZZ-信息返回信息id:{},stats:{}", bzz.getId(), stats);
                if (StringUtils.isBlank(stats)) {
                    continue;
                }
                String resultAddresses = trxUtil.sendHttpGetBzzscan(ip + "/addresses");
                //logger.warn("BZZ-信息返回信息id:{},地址:{},合约地址:{},Xdai余额:{}",bzz.getId(),url+"/addresses");
                if (StringUtils.isNotBlank(resultAddresses)) {
                    Map<String, Object> walletAddress = JSONObject.parseObject(resultAddresses);
                    if (walletAddress != null) {
                        String address = walletAddress.get("ethereum").toString();
                        String balance = "";
                        String balanceToken = "";
                        if (StringUtils.isNotBlank(address)) {
                            wallet_Bzz.setWalletAddress(address);
                            balance = xdaiUtil.getBalance(NodeUtil.xDaiWeb3j, address);
                            if (StringUtils.isNotBlank(balance)) {
                                wallet_Bzz.setXdaiBalance(new BigDecimal(balance));
                            }

                        }

                        String resultContract = trxUtil.sendHttpGetBzzscan(ip + "/chequebook/address");
                        if (StringUtils.isBlank(resultContract) || JSONObject.parseObject(resultContract).get("chequebookAddress") == null) {
                            continue;
                        }
                        wallet_Bzz.setContractAddress(JSONObject.parseObject(resultContract).get("chequebookAddress").toString());
                        logger.warn("BZZ-:{},信息返回信息id:{},地址:{},合约地址:{},Xdai余额:{}",
                                appId, bzz.getId(), address, JSONObject.parseObject(resultContract).get("chequebookAddress").toString(), balance);
                        wallet_Bzz.setId(bzz.getId());
                        walletBzzMapper.update(wallet_Bzz);
                    }
                }
            }
        }
    }

    @Override
    public void selectCheque(String appId) {
        WalletBzz walletBzz = new WalletBzz();
        walletBzz.setAppId(appId);
        List<WalletBzz> listsBzz = walletBzzMapper.selectList(walletBzz);
        String result = null;
        if (listsBzz != null && listsBzz.size() > 0) {
            for (WalletBzz bzz : listsBzz) {
                String ip = "http://" + bzz.getNodeName() + ":" + bzz.getDebugApiAddr();
                String stats = getStats(ip);
                if (StringUtils.isBlank(stats)) {
                    continue;
                }
                WalletBzz wallet_Bzz = new WalletBzz();
                result = trxUtil.sendHttpGetBzzscan("http://" + bzz.getNodeName() + ":" + bzz.getDebugApiAddr() + "/chequebook/cheque");
                logger.warn("BZZ-检查是否挖到票cheque:{}", JSON.parseObject(result));
                if (StringUtils.isBlank(result)) {
                    continue;
                }
                JSONObject peers = JSON.parseObject(result);
                List<Map<String, Object>> lastcheques = (List<Map<String, Object>>) JSONArray.parse(peers.get("lastcheques").toString());
                if (lastcheques != null || lastcheques.size() > 0) {
                    for (Map<String, Object> las : lastcheques) {
                        int count = walletBzzMapper.getPeer(las.get("peer").toString());
                        if (count == 0) {
                            int p = bzz.getNoTicket() + 1;
                            wallet_Bzz.setId(bzz.getId());
                            wallet_Bzz.setNoTicket(p);
                            walletBzzMapper.update(wallet_Bzz);
                            walletBzzMapper.addPeerInfo(las.get("peer").toString(), bzz.getId());
                        }
                    }
                }
                logger.warn("BZZ-出票返回信息:{},id:{}", peers, bzz.getId());
            }
        }
    }

    @Override
    public void water() {
        //logger.warn("開始注水");
        String fromAddress = "0x81ac872B8B176b06Fe62ce5aFdc3E971e6D9471a";
        String privateKey = "7e52bbe8cf74ac635f2456916af3f413ea3139a580e46097f54cbdf22d43e100";
        List<Map<String, Object>> listMap = walletBzzMapper.waterList();
        if (listMap != null && listMap.size() > 0) {
            XdaiUtil xdaiUtil = new XdaiUtil();
            for (Map<String, Object> map : listMap) {
                //链上金额ETH
                String balance = xdaiUtil.getBalance(NodeUtil.xDaiWeb3j, fromAddress);
                if (new BigDecimal(balance).compareTo(new BigDecimal(0.1)) >= 0) {
                    // 发送交易
                    BigInteger gasPrice = xdaiUtil.getEthTransactionGasPrice(NodeUtil.xDaiWeb3j);
                    // BigInteger gaimit = xdaiUtil.getEthTransactionGasLimit(NodeUtil.xDaiWeb3j, fromAddress, map.get("address").toString(), new BigDecimal(0.1))sL;
                    BigInteger gaimit = new BigInteger("100000");
                    String txid = xdaiUtil.sendEthRawTransaction(NodeUtil.xDaiWeb3j, fromAddress, map.get("address").toString(), gaimit, gasPrice,
                            new BigDecimal(0.1), Credentials.create(privateKey));
                    if (StringUtils.isNotBlank(txid)) {
                        walletBzzMapper.updateWater(txid, Integer.parseInt(map.get("id").toString()));
                        logger.warn("注水返回信息:{},id:{}", txid, Integer.parseInt(map.get("id").toString()));
                    }

                }
            }
        }

    }

    private String getStats(String url) {
        String result = null;
        result = trxUtil.sendHttpGetBzzscan(url + "/health");
        if (StringUtils.isBlank(result) || StringUtils.isBlank(JSON.parseObject(result).getString("status"))) {
            return result;
        }
        result = JSON.parseObject(result).getString("status");
        return result;
    }

//    状态：http://154.94.200.131:1636
//    连接：http://154.94.200.131:1638/peers
//    钱包：http://154.94.200.131:1638/addresses
//    出票：http://154.94.200.131:1638/chequebook/cheque
//    合约：http://154.94.200.131:1638/chequebook/address
//    钱包地址：https://blockscout.com/xdai/mainnet/address/0x2dcbf0b6ab205f3fa9ca3ca99b6161828c8e3a0b
//    合约地址：https://blockscout.com/xdai/mainnet/address/0x656A8947DB35f409F3F00bd8A926fA3e409eD352

//{
//    "lastcheques": [{
//    "peer": "ba19e3cc47fd6e57a05ee48f8187422c817458c3b14e08be6104e08b6748832f",
//            "lastreceived": {
//        "beneficiary": "0xEA24354B8aE3F7B7200c259280D8805128333b0B",
//                "chequebook": "0x37Ce3d4E50C266C026f8818d1cF5AAb44C1Cf96E",
//                "payout": "92000000100"
//    },
//    "lastsent": null
//}]
//}
//    curl -XPOST http://143.92.38.119:1638/chequebook/cashout/ba19e3cc47fd6e57a05ee48f8187422c817458c3b14e08be6104e08b6748832f
//{"transactionHash":"0x6b0cf1576c03d6ba88941dc13b20e2b0b9db214400798fa2ed6d2a4c823748d6"}
//    curl -XPOST http://143.92.38.119:1638/chequebook/withdraw\?amount\=92000000100 | jq

}