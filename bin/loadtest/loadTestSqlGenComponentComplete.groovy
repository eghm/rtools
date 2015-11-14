def String SQL = "-- LOAD TEST LOAD_TEST_DESC\n" +
"INSERT INTO `krew_doc_hdr_s` VALUES ('KREW_DOC_HDR_ID');\n" +
"INSERT INTO `krew_doc_hdr_t` VALUES ('KREW_DOC_HDR_ID','3007','R',0,'2014-03-20 14:40:41','2014-03-20 14:39:34',NULL,NULL,'2014-03-20 14:40:41','New ComponentBo - LOAD_TEST_DESC ',NULL,1,'admin',5,'admin',NULL,'KREW_DOC_HDR_OBJ_ID',NULL,NULL);\n\n" +

"INSERT INTO `krns_maint_lock_s` VALUES ('KRNS_MAINT_LOCK_ID');\n" +
"INSERT INTO `krns_maint_lock_t` VALUES ('org.kuali.rice.coreservice.impl.component.ComponentBo!!namespaceCode^^KR-WKFLW::code^^LOAD_TEST_DESCcode','KRNS_MAINT_LOCK_OBJ_ID',1,'KREW_DOC_HDR_ID','KRNS_MAINT_LOCK_ID');\n\n" +

"INSERT INTO `krew_actn_rqst_t` VALUES ('KREW_ACTN_RQST_ID',NULL,'C','KREW_DOC_HDR_ID',NULL,'A','-1','eric',NULL,NULL,NULL,'U',0,NULL,0,'KREW_RTE_NODE_INSTN_ID',NULL,1,'2014-03-20 14:40:41','',1,'Ad Hoc Routed by admin',NULL,'F',1,0,NULL,NULL);\n" +

"INSERT INTO `krew_actn_itm_t` VALUES ('KREW_ACTN_ITM_ID','eric','2014-03-20 14:40:43','C','KREW_ACTN_RQST_ID','KREW_DOC_HDR_ID',NULL,NULL,'New ComponentBo - Load Test LOAD_TEST_DESC ','Component Maintenance Document','\${kr-url}/maintenance.do?methodToCall=docHandler','ComponentMaintenanceDocument','-1',NULL,0,NULL,NULL,NULL,NULL);\n" +

"INSERT INTO `krew_rte_node_instn_t` VALUES ('KREW_RTE_NODE_INSTN_ID','KREW_DOC_HDR_ID','2917','KREW_RTE_BRCH_ID',NULL,1,0,0,2);\n" +

"INSERT INTO `krew_init_rte_node_instn_t` VALUES ('KREW_DOC_HDR_ID','KREW_RTE_NODE_INSTN_ID');\n" +

"INSERT INTO `krew_rte_brch_t` VALUES ('KREW_RTE_BRCH_ID','PRIMARY',NULL,'KREW_RTE_NODE_INSTN_ID',NULL,NULL,1);\n" +

"INSERT INTO `krns_doc_hdr_t` VALUES ('KREW_DOC_HDR_ID','KRNS_DOC_HDR_OBJ_ID',1,'LOAD_TEST_DESC',NULL,NULL,NULL);\n\n\n";


def int loadTestCount = 0;
def int numberToCreate = Integer.parseInt(args[0]);
def int krewDocHdrId = Integer.parseInt(args[1]);
def int krewActnTknId = Integer.parseInt(args[2]);
def int krewRteNodeInsnId = Integer.parseInt(args[3]);
def int krewActnRqstId = Integer.parseInt(args[4]);
def int krewRteBrchId = Integer.parseInt(args[5]);
def int krnsMaintLockId = Integer.parseInt(args[6]);
def String sqlGen;
def uid = new java.rmi.server.UID();

while (loadTestCount < numberToCreate) {
	sqlGen = SQL.replace("KREW_DOC_HDR_ID", krewDocHdrId + "");
	sqlGen = sqlGen.replace("KREW_ACTN_ITM_ID", krewActnTknId + "");
	sqlGen = sqlGen.replace("KREW_RTE_NODE_INSTN_ID", krewRteNodeInsnId + "");
	sqlGen = sqlGen.replace("KREW_ACTN_RQST_ID", krewActnRqstId + "");
	sqlGen = sqlGen.replace("KREW_RTE_BRCH_ID", krewRteBrchId + "");
	sqlGen = sqlGen.replace("KRNS_MAINT_LOCK_ID", krnsMaintLockId + "");

	sqlGen = sqlGen.replace("LOAD_TEST_DESC", krewDocHdrId + " load test data");

	sqlGen = sqlGen.replace("KREW_DOC_HDR_OBJ_ID", (new java.rmi.server.UID()).toString());
	sqlGen = sqlGen.replace("KRNS_DOC_HDR_OBJ_ID", (new java.rmi.server.UID()).toString());
	sqlGen = sqlGen.replace("KRNS_MAINT_LOCK_OBJ_ID", (new java.rmi.server.UID()).toString());

	System.out.println(sqlGen);

	loadTestCount++;
	krewDocHdrId++;
	krewActnTknId++;
	krewRteNodeInsnId++;
}