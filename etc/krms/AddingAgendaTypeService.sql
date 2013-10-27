-- KRMS Demo https://docs.google.com/a/kuali.org/presentation/d/1-XGSnnLu9Umwstpl-2N0i-5WPVFVbe8RuLu3r7kLaSk/edit
-- first add the type itself
insert into krms_typ_t (typ_id, nm, nmspc_cd, srvc_nm, actv, ver_nbr) values ('T6', 'Campus Agenda', 'KR-SAP', 'campusAgendaTypeService', 'Y', 1);

-- add campus attribute to Campus Agenda Type
insert into krms_attr_defn_t (ATTR_DEFN_ID, NM, NMSPC_CD, LBL, CMPNT_NM, DESC_TXT) values ('Q9901', 'Campus', 'KR-SAP', 'campus label', null, 'the campus which this agenda is valid for');
insert into krms_typ_attr_t (TYP_ATTR_ID, SEQ_NO, TYP_ID, ATTR_DEFN_ID) values ('T6A', 1, 'T6', 'Q9901');

-- done via the ui in the demo
insert into krms_cntxt_t (cntxt_id, nmspc_cd, nm, actv, ver_nbr, desc_txt) values ('TRAVELACCT', 'KR-SAP', 'Travel account context', 'Y', 1, 'for KRMS demo');

-- make the type valid for our context
insert into krms_cntxt_vld_agenda_typ_t (cntxt_vld_agenda_id, cntxt_id, agenda_typ_id, ver_nbr) values ('TAT6', 'TRAVELACCT', 'T6', 1);

-- make the action type for our context
insert into krms_cntxt_vld_actn_typ_t (cntxt_vld_actn_id, cntxt_id, actn_typ_id, ver_nbr) values ('SA1', 'TRAVELACCT', '1001', 1);

-- Generic Workflow Properties
insert into krms_ctgry_t (ctgry_id, nm, nmspc_cd, ver_nbr) values ('CAT02', 'Workflow Document Properties', 'KR-SAP', '1');

--Travel Account Properties
insert into krms_ctgry_t (ctgry_id, nm, nmspc_cd, ver_nbr) values ('CAT03', 'Travel Account Properties', 'KR-SAP', '1');