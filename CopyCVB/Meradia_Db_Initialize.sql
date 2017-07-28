
-- --------------------------------------------------
-- Initialize meradia_db on the target AZURE
-- SQL Server. 
--
-- May 2017: TEA: Initial version.
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE meradia_db;
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[FK_application_BA0E0FB1_847C_4FE9_97E1_1807400DFF59]', 'F') IS NOT NULL
    ALTER TABLE [application] DROP CONSTRAINT [FK_application_BA0E0FB1_847C_4FE9_97E1_1807400DFF59];
GO
IF OBJECT_ID(N'[FK_application_D93CAFE2_39E8_4459_9101_8B061C9A5670]', 'F') IS NOT NULL
    ALTER TABLE [application] DROP CONSTRAINT [FK_application_D93CAFE2_39E8_4459_9101_8B061C9A5670];
GO
IF OBJECT_ID(N'[FK_article_60D831CF_722E_4D75_9455_5DCFF7324AFE]', 'F') IS NOT NULL
    ALTER TABLE [publication] DROP CONSTRAINT [FK_article_60D831CF_722E_4D75_9455_5DCFF7324AFE];
GO
IF OBJECT_ID(N'[FK_company_info_73948F99_6291_4E17_9CF0_738A6D600F41]', 'F') IS NOT NULL
    ALTER TABLE [company_info] DROP CONSTRAINT [FK_company_info_73948F99_6291_4E17_9CF0_738A6D600F41];
GO
IF OBJECT_ID(N'[FK_consultant_09553624_1731_467E_8CB6_75F507975046]', 'F') IS NOT NULL
    ALTER TABLE [consultant] DROP CONSTRAINT [FK_consultant_09553624_1731_467E_8CB6_75F507975046];
GO
IF OBJECT_ID(N'[FK_consultant_application_0532CD07_BD99_4DA3_8E72_34A9E114425F]', 'F') IS NOT NULL
    ALTER TABLE [consultant_application] DROP CONSTRAINT [FK_consultant_application_0532CD07_BD99_4DA3_8E72_34A9E114425F];
GO
IF OBJECT_ID(N'[FK_consultant_application_05C5F6D7_49C2_4724_985A_65C5EDC74E33]', 'F') IS NOT NULL
    ALTER TABLE [consultant_application] DROP CONSTRAINT [FK_consultant_application_05C5F6D7_49C2_4724_985A_65C5EDC74E33];
GO
IF OBJECT_ID(N'[FK_consultant_application_D84372A0_5CF6_48BA_82A0_2AEB0317517D]', 'F') IS NOT NULL
    ALTER TABLE [consultant_application] DROP CONSTRAINT [FK_consultant_application_D84372A0_5CF6_48BA_82A0_2AEB0317517D];
GO
IF OBJECT_ID(N'[FK_consultant_biography_3DFDCB39_8D9E_466B_A7C4_5E164D59029C]', 'F') IS NOT NULL
    ALTER TABLE [consultant_biography] DROP CONSTRAINT [FK_consultant_biography_3DFDCB39_8D9E_466B_A7C4_5E164D59029C];
GO
IF OBJECT_ID(N'[FK_consultant_certification_611F43F4_B959_4E86_BB28_A0ADCF2449D2]', 'F') IS NOT NULL
    ALTER TABLE [consultant_certification] DROP CONSTRAINT [FK_consultant_certification_611F43F4_B959_4E86_BB28_A0ADCF2449D2];
GO
IF OBJECT_ID(N'[FK_consultant_education_10182284_20C2_407C_A1B5_36F95258E23A]', 'F') IS NOT NULL
    ALTER TABLE [consultant_education] DROP CONSTRAINT [FK_consultant_education_10182284_20C2_407C_A1B5_36F95258E23A];
GO
IF OBJECT_ID(N'[FK_consultant_employment_hi_8332EF55_9DE1_423F_BE57_104A290FDF6A]', 'F') IS NOT NULL
    ALTER TABLE [consultant_employment_history] DROP CONSTRAINT [FK_consultant_employment_hi_8332EF55_9DE1_423F_BE57_104A290FDF6A];
GO
IF OBJECT_ID(N'[FK_consultant_employment_hi_E076870E_EFAF_41D1_A0DF_A4EF75C0505D]', 'F') IS NOT NULL
    ALTER TABLE [consultant_employment_history] DROP CONSTRAINT [FK_consultant_employment_hi_E076870E_EFAF_41D1_A0DF_A4EF75C0505D];
GO
IF OBJECT_ID(N'[FK_consultant_experience_17588600_E1FB_486C_A6F7_99C79EDFFFE3]', 'F') IS NOT NULL
    ALTER TABLE [experience] DROP CONSTRAINT [FK_consultant_experience_17588600_E1FB_486C_A6F7_99C79EDFFFE3];
GO
IF OBJECT_ID(N'[FK_consultant_experience_9853426D_05AC_4213_819A_DC51BFB2110C]', 'F') IS NOT NULL
    ALTER TABLE [experience] DROP CONSTRAINT [FK_consultant_experience_9853426D_05AC_4213_819A_DC51BFB2110C];
GO
IF OBJECT_ID(N'[FK_consultant_experience_de_14142970_A023_47FB_928E_CEEDA7A3DF70]', 'F') IS NOT NULL
    ALTER TABLE [experience_detail] DROP CONSTRAINT [FK_consultant_experience_de_14142970_A023_47FB_928E_CEEDA7A3DF70];
GO
IF OBJECT_ID(N'[FK_consultant_experience_de_24935C47_C285_422C_860A_FB16D48EA4AD]', 'F') IS NOT NULL
    ALTER TABLE [experience_detail] DROP CONSTRAINT [FK_consultant_experience_de_24935C47_C285_422C_860A_FB16D48EA4AD];
GO
IF OBJECT_ID(N'[FK_consultant_skill_28A0DBD8_DB60_44EB_B061_D43E9A35EBF7]', 'F') IS NOT NULL
    ALTER TABLE [consultant_skill] DROP CONSTRAINT [FK_consultant_skill_28A0DBD8_DB60_44EB_B061_D43E9A35EBF7];
GO
IF OBJECT_ID(N'[FK_consultant_skill_B4B1E3F9_48E6_4517_8D10_A2473AC54831]', 'F') IS NOT NULL
    ALTER TABLE [consultant_skill] DROP CONSTRAINT [FK_consultant_skill_B4B1E3F9_48E6_4517_8D10_A2473AC54831];
GO
IF OBJECT_ID(N'[FK_consultant_skill_E3B4A3D9_D9F4_40BE_8087_71A156A28BE3]', 'F') IS NOT NULL
    ALTER TABLE [consultant_skill] DROP CONSTRAINT [FK_consultant_skill_E3B4A3D9_D9F4_40BE_8087_71A156A28BE3];
GO
IF OBJECT_ID(N'[FK_consultant_summary_C0D51633_5DE7_4765_9088_55CB55B42D06]', 'F') IS NOT NULL
    ALTER TABLE [consultant_summary] DROP CONSTRAINT [FK_consultant_summary_C0D51633_5DE7_4765_9088_55CB55B42D06];
GO
IF OBJECT_ID(N'[FK_exp_72AA7967_C60A_4A53_9C1C_FDED2B4B53E4]', 'F') IS NOT NULL
    ALTER TABLE [exp] DROP CONSTRAINT [FK_exp_72AA7967_C60A_4A53_9C1C_FDED2B4B53E4];
GO
IF OBJECT_ID(N'[FK_exp_D4497879_2AFD_4D88_80BE_319EFB05F584]', 'F') IS NOT NULL
    ALTER TABLE [exp] DROP CONSTRAINT [FK_exp_D4497879_2AFD_4D88_80BE_319EFB05F584];
GO
IF OBJECT_ID(N'[FK_exp_DBCDEE78_FAD5_4382_8BCC_18C1E1D7B588]', 'F') IS NOT NULL
    ALTER TABLE [exp] DROP CONSTRAINT [FK_exp_DBCDEE78_FAD5_4382_8BCC_18C1E1D7B588];
GO
IF OBJECT_ID(N'[FK_exp_detail_AB1F14AA_544A_4984_92F6_E556F2D6B6D3]', 'F') IS NOT NULL
    ALTER TABLE [exp_detail] DROP CONSTRAINT [FK_exp_detail_AB1F14AA_544A_4984_92F6_E556F2D6B6D3];
GO
IF OBJECT_ID(N'[FK_exp_detail_CC0A8F4A_627A_474D_B853_45F485E0C720]', 'F') IS NOT NULL
    ALTER TABLE [exp_detail] DROP CONSTRAINT [FK_exp_detail_CC0A8F4A_627A_474D_B853_45F485E0C720];
GO
IF OBJECT_ID(N'[FK_exp_ECDA59DF_D8C1_4BF5_9D7D_62FEED5848E6]', 'F') IS NOT NULL
    ALTER TABLE [exp] DROP CONSTRAINT [FK_exp_ECDA59DF_D8C1_4BF5_9D7D_62FEED5848E6];
GO
IF OBJECT_ID(N'[FK_exp_F2E3737F_9EA4_4028_A8A2_D6EF66DB1802]', 'F') IS NOT NULL
    ALTER TABLE [exp] DROP CONSTRAINT [FK_exp_F2E3737F_9EA4_4028_A8A2_D6EF66DB1802];
GO
IF OBJECT_ID(N'[FK_exp_view_27BBD070_FF0C_494D_9EB2_3A43D7942054]', 'F') IS NOT NULL
    ALTER TABLE [exp_layout] DROP CONSTRAINT [FK_exp_view_27BBD070_FF0C_494D_9EB2_3A43D7942054];
GO
IF OBJECT_ID(N'[FK_exp_view_3ED09352_9C09_4000_9E1B_FEAA70ABBFBB]', 'F') IS NOT NULL
    ALTER TABLE [exp_layout] DROP CONSTRAINT [FK_exp_view_3ED09352_9C09_4000_9E1B_FEAA70ABBFBB];
GO
IF OBJECT_ID(N'[FK_exp_view_C0BF97BA_7B07_4CAE_AA09_B0ACEDCB97CC]', 'F') IS NOT NULL
    ALTER TABLE [exp_layout] DROP CONSTRAINT [FK_exp_view_C0BF97BA_7B07_4CAE_AA09_B0ACEDCB97CC];
GO
IF OBJECT_ID(N'[FK_exp_view_FCDC0557_7F22_4CE1_B50A_2195A423F79F]', 'F') IS NOT NULL
    ALTER TABLE [exp_layout] DROP CONSTRAINT [FK_exp_view_FCDC0557_7F22_4CE1_B50A_2195A423F79F];
GO
IF OBJECT_ID(N'[FK_exp_view_grp_221A90E3_5C6B_4ED8_B825_60EA383BFBEC]', 'F') IS NOT NULL
    ALTER TABLE [exp_layout_grp] DROP CONSTRAINT [FK_exp_view_grp_221A90E3_5C6B_4ED8_B825_60EA383BFBEC];
GO
IF OBJECT_ID(N'[FK_exp_view_grp_dtl_A3B0F7ED_901F_4721_8692_5717BDBCB4D4]', 'F') IS NOT NULL
    ALTER TABLE [exp_layout_grp_dtl] DROP CONSTRAINT [FK_exp_view_grp_dtl_A3B0F7ED_901F_4721_8692_5717BDBCB4D4];
GO
IF OBJECT_ID(N'[FK_noteworthy_sow_7BF85959_9DDD_4C25_81BF_B5162395014F]', 'F') IS NOT NULL
    ALTER TABLE [noteworthy_sow] DROP CONSTRAINT [FK_noteworthy_sow_7BF85959_9DDD_4C25_81BF_B5162395014F];
GO
IF OBJECT_ID(N'[FK_noteworthy_sow_A9057B58_3D01_43C0_A36E_4B88B8C7DFA2]', 'F') IS NOT NULL
    ALTER TABLE [noteworthy_sow] DROP CONSTRAINT [FK_noteworthy_sow_A9057B58_3D01_43C0_A36E_4B88B8C7DFA2];
GO
IF OBJECT_ID(N'[FK_sow_1547570A_DCDE_4EF6_87CA_00493E0C44C2]', 'F') IS NOT NULL
    ALTER TABLE [sow] DROP CONSTRAINT [FK_sow_1547570A_DCDE_4EF6_87CA_00493E0C44C2];
GO
IF OBJECT_ID(N'[FK_sow_2AAD7C02_51AB_424D_BDFB_F37E29685BD9]', 'F') IS NOT NULL
    ALTER TABLE [sow] DROP CONSTRAINT [FK_sow_2AAD7C02_51AB_424D_BDFB_F37E29685BD9];
GO
IF OBJECT_ID(N'[FK_sow_317FADBD_90B1_4BE1_9952_63945D498100]', 'F') IS NOT NULL
    ALTER TABLE [sow] DROP CONSTRAINT [FK_sow_317FADBD_90B1_4BE1_9952_63945D498100];
GO
IF OBJECT_ID(N'[FK_sow_consultant_A34D3157_971A_4DED_BBD1_7BDDA9657221]', 'F') IS NOT NULL
    ALTER TABLE [sow_consultant] DROP CONSTRAINT [FK_sow_consultant_A34D3157_971A_4DED_BBD1_7BDDA9657221];
GO
IF OBJECT_ID(N'[FK_sow_consultant_F51D4888_C50E_44C8_B659_FB1C722BF9DF]', 'F') IS NOT NULL
    ALTER TABLE [sow_consultant] DROP CONSTRAINT [FK_sow_consultant_F51D4888_C50E_44C8_B659_FB1C722BF9DF];
GO
IF OBJECT_ID(N'[FK_sow_E64A6566_7C39_484E_BB65_1A0C7C0E07FE]', 'F') IS NOT NULL
    ALTER TABLE [sow] DROP CONSTRAINT [FK_sow_E64A6566_7C39_484E_BB65_1A0C7C0E07FE];
GO
IF OBJECT_ID(N'[FK_speaking_engagement_38051F2B_E596_4A56_B8CE_52F1217E96CF]', 'F') IS NOT NULL
    ALTER TABLE [speaking_engagement] DROP CONSTRAINT [FK_speaking_engagement_38051F2B_E596_4A56_B8CE_52F1217E96CF];
GO
IF OBJECT_ID(N'[FK_speaking_engagement_7195E0EA_544B_4687_A862_C4F64C3E148E]', 'F') IS NOT NULL
    ALTER TABLE [speaking_engagement] DROP CONSTRAINT [FK_speaking_engagement_7195E0EA_544B_4687_A862_C4F64C3E148E];
GO
IF OBJECT_ID(N'[FK_timeslip_1F1D7E5F_C9BA_440D_B4C9_C1C8323AC8D0]', 'F') IS NOT NULL
    ALTER TABLE [timeslip] DROP CONSTRAINT [FK_timeslip_1F1D7E5F_C9BA_440D_B4C9_C1C8323AC8D0];
GO
IF OBJECT_ID(N'[FK_timeslip_46AC1811_658D_43D8_A1A1_B15D0521C937]', 'F') IS NOT NULL
    ALTER TABLE [timeslip] DROP CONSTRAINT [FK_timeslip_46AC1811_658D_43D8_A1A1_B15D0521C937];
GO
IF OBJECT_ID(N'[FK_timeslip_9977087E_C7FB_4BFA_BD85_AAA31928E41C]', 'F') IS NOT NULL
    ALTER TABLE [timeslip] DROP CONSTRAINT [FK_timeslip_9977087E_C7FB_4BFA_BD85_AAA31928E41C];
GO
IF OBJECT_ID(N'[FK_timeslip_phase_FF77D194_1417_4139_BBB4_130AFBC812F1]', 'F') IS NOT NULL
    ALTER TABLE [timeslip_phase] DROP CONSTRAINT [FK_timeslip_phase_FF77D194_1417_4139_BBB4_130AFBC812F1];
GO
IF OBJECT_ID(N'[FK_white_paper_99A181AF_B435_4C8D_8870_5D76D0F4DFA1]', 'F') IS NOT NULL
    ALTER TABLE [white_paper] DROP CONSTRAINT [FK_white_paper_99A181AF_B435_4C8D_8870_5D76D0F4DFA1];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[app_domain]', 'U') IS NOT NULL
    DROP TABLE [app_domain];
GO
IF OBJECT_ID(N'[app_vendor]', 'U') IS NOT NULL
    DROP TABLE [app_vendor];
GO
IF OBJECT_ID(N'[application]', 'U') IS NOT NULL
    DROP TABLE [application];
GO
IF OBJECT_ID(N'[audit]', 'U') IS NOT NULL
    DROP TABLE [audit];
GO
IF OBJECT_ID(N'[company]', 'U') IS NOT NULL
    DROP TABLE [company];
GO
IF OBJECT_ID(N'[company_info]', 'U') IS NOT NULL
    DROP TABLE [company_info];
GO
IF OBJECT_ID(N'[consultant]', 'U') IS NOT NULL
    DROP TABLE [consultant];
GO
IF OBJECT_ID(N'[consultant_application]', 'U') IS NOT NULL
    DROP TABLE [consultant_application];
GO
IF OBJECT_ID(N'[consultant_biography]', 'U') IS NOT NULL
    DROP TABLE [consultant_biography];
GO
IF OBJECT_ID(N'[consultant_certification]', 'U') IS NOT NULL
    DROP TABLE [consultant_certification];
GO
IF OBJECT_ID(N'[consultant_education]', 'U') IS NOT NULL
    DROP TABLE [consultant_education];
GO
IF OBJECT_ID(N'[consultant_employment_history]', 'U') IS NOT NULL
    DROP TABLE [consultant_employment_history];
GO
IF OBJECT_ID(N'[consultant_skill]', 'U') IS NOT NULL
    DROP TABLE [consultant_skill];
GO
IF OBJECT_ID(N'[consultant_summary]', 'U') IS NOT NULL
    DROP TABLE [consultant_summary];
GO
IF OBJECT_ID(N'[domain]', 'U') IS NOT NULL
    DROP TABLE [domain];
GO
IF OBJECT_ID(N'[event_role]', 'U') IS NOT NULL
    DROP TABLE [event_role];
GO
IF OBJECT_ID(N'[exp]', 'U') IS NOT NULL
    DROP TABLE [exp];
GO
IF OBJECT_ID(N'[exp_detail]', 'U') IS NOT NULL
    DROP TABLE [exp_detail];
GO
IF OBJECT_ID(N'[exp_layout]', 'U') IS NOT NULL
    DROP TABLE [exp_layout];
GO
IF OBJECT_ID(N'[exp_layout_grp]', 'U') IS NOT NULL
    DROP TABLE [exp_layout_grp];
GO
IF OBJECT_ID(N'[exp_layout_grp_dtl]', 'U') IS NOT NULL
    DROP TABLE [exp_layout_grp_dtl];
GO
IF OBJECT_ID(N'[exp_sort_col]', 'U') IS NOT NULL
    DROP TABLE [exp_sort_col];
GO
IF OBJECT_ID(N'[experience]', 'U') IS NOT NULL
    DROP TABLE [experience];
GO
IF OBJECT_ID(N'[experience_detail]', 'U') IS NOT NULL
    DROP TABLE [experience_detail];
GO
IF OBJECT_ID(N'[holidays]', 'U') IS NOT NULL
    DROP TABLE [holidays];
GO
IF OBJECT_ID(N'[noteworthy_sow]', 'U') IS NOT NULL
    DROP TABLE [noteworthy_sow];
GO
IF OBJECT_ID(N'[proficiency]', 'U') IS NOT NULL
    DROP TABLE [proficiency];
GO
IF OBJECT_ID(N'[project_type]', 'U') IS NOT NULL
    DROP TABLE [project_type];
GO
IF OBJECT_ID(N'[publication]', 'U') IS NOT NULL
    DROP TABLE [publication];
GO
IF OBJECT_ID(N'[role]', 'U') IS NOT NULL
    DROP TABLE [role];
GO
IF OBJECT_ID(N'[skill]', 'U') IS NOT NULL
    DROP TABLE [skill];
GO
IF OBJECT_ID(N'[sow]', 'U') IS NOT NULL
    DROP TABLE [sow];
GO
IF OBJECT_ID(N'[sow_consultant]', 'U') IS NOT NULL
    DROP TABLE [sow_consultant];
GO
IF OBJECT_ID(N'[speaking_engagement]', 'U') IS NOT NULL
    DROP TABLE [speaking_engagement];
GO
IF OBJECT_ID(N'[thought_leadership]', 'U') IS NOT NULL
    DROP TABLE [thought_leadership];
GO
IF OBJECT_ID(N'[timeslip]', 'U') IS NOT NULL
    DROP TABLE [timeslip];
GO
IF OBJECT_ID(N'[timeslip_period]', 'U') IS NOT NULL
    DROP TABLE [timeslip_period];
GO
IF OBJECT_ID(N'[timeslip_phase]', 'U') IS NOT NULL
    DROP TABLE [timeslip_phase];
GO
IF OBJECT_ID(N'[timeslip_role]', 'U') IS NOT NULL
    DROP TABLE [timeslip_role];
GO
IF OBJECT_ID(N'[timeslip_task]', 'U') IS NOT NULL
    DROP TABLE [timeslip_task];
GO
IF OBJECT_ID(N'[title]', 'U') IS NOT NULL
    DROP TABLE [title];
GO
IF OBJECT_ID(N'[white_paper]', 'U') IS NOT NULL
    DROP TABLE [white_paper];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'app_domain'
CREATE TABLE [app_domain] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [app_domain_nm] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'app_vendor'
CREATE TABLE [app_vendor] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [app_vendor_nm] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'application'
CREATE TABLE [application] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [application_nm] nvarchar(50)  NOT NULL,
    [application_descr] nvarchar(max)  NULL,
    [app_vendor_id] int  NULL,
    [app_domain_id] int  NULL,
    [formal_nm] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'audit'
CREATE TABLE [audit] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [table_nm] nvarchar(220)  NOT NULL,
    [record_id] int  NOT NULL,
    [time_stamp] datetime  NOT NULL,
    [tran_type] nvarchar(220)  NOT NULL,
    [field_nm] nvarchar(220)  NULL,
    [consultant_id] int  NULL
);
GO

-- Creating table 'company'
CREATE TABLE [company] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [company_nm] nvarchar(100)  NOT NULL,
    [company_location] nvarchar(200)  NULL,
    [is_client] bit  NOT NULL,
    [company_descr] nvarchar(220)  NULL,
    [company_short_nm] nvarchar(40)  NOT NULL
);
GO

-- Creating table 'company_info'
CREATE TABLE [company_info] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [company_nm] nvarchar(220)  NULL,
    [owner_nm] nvarchar(220)  NULL,
    [owner_title] nvarchar(220)  NULL,
    [app_owner] nvarchar(220)  NULL,
    [app_owner_title] nvarchar(220)  NULL,
    [street_address] nvarchar(220)  NULL,
    [city] nvarchar(220)  NULL,
    [state] nvarchar(220)  NULL,
    [phone_number] nvarchar(220)  NULL,
    [fax_number] nvarchar(220)  NULL,
    [website] nvarchar(max)  NULL,
    [home_page_greeting] nvarchar(max)  NULL,
    [zip_code] nvarchar(220)  NULL,
    [sharepoint_site] nvarchar(max)  NULL,
    [meradia_globe] int  NULL,
    [sow_id] int  NULL
);
GO

-- Creating table 'consultant'
CREATE TABLE [consultant] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_nm] nvarchar(50)  NOT NULL,
    [title_id] int  NOT NULL,
    [consultant_initials] nvarchar(3)  NOT NULL,
    [start_dt] datetime  NULL,
    [end_dt] datetime  NULL,
    [image_url] nvarchar(max)  NULL,
    [is_admin] bit  NOT NULL,
    [is_manager] bit  NOT NULL,
    [email_address] nvarchar(220)  NULL,
    [noteworthy_intro] nvarchar(220)  NULL,
    [birth_dt] datetime  NULL,
    [headshot] int  NULL,
    [vacation_available] decimal(28,6)  NULL
);
GO

-- Creating table 'consultant_application'
CREATE TABLE [consultant_application] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NOT NULL,
    [application_id] int  NOT NULL,
    [order_nbr] int  NOT NULL,
    [suppressed] bit  NOT NULL,
    [proficiency_id] int  NULL,
    [suppressed_RIC] nvarchar(3)  NOT NULL
);
GO

-- Creating table 'consultant_biography'
CREATE TABLE [consultant_biography] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NOT NULL,
    [bio_txt] nvarchar(max)  NOT NULL,
    [show] bit  NOT NULL,
    [bio_descr] nvarchar(220)  NULL,
    [show_RIC] nvarchar(3)  NOT NULL
);
GO

-- Creating table 'consultant_certification'
CREATE TABLE [consultant_certification] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NOT NULL,
    [certificate_nm] nvarchar(220)  NOT NULL,
    [certificate_nbr] nvarchar(220)  NULL,
    [issuer_nm] nvarchar(220)  NULL,
    [acquired_dt] datetime  NULL,
    [expiration_dt] datetime  NULL,
    [order_nbr] int  NOT NULL
);
GO

-- Creating table 'consultant_education'
CREATE TABLE [consultant_education] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NOT NULL,
    [degree_nm] nvarchar(220)  NOT NULL,
    [institution_nm] nvarchar(220)  NOT NULL,
    [acquired_dt] datetime  NULL,
    [order_nbr] int  NULL
);
GO

-- Creating table 'consultant_employment_history'
CREATE TABLE [consultant_employment_history] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NOT NULL,
    [company_id] int  NOT NULL,
    [start_dt] datetime  NULL,
    [end_dt] datetime  NULL
);
GO

-- Creating table 'consultant_skill'
CREATE TABLE [consultant_skill] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NOT NULL,
    [skill_id] int  NOT NULL,
    [order_nbr] int  NOT NULL,
    [suppressed] bit  NOT NULL,
    [proficiency_id] int  NULL,
    [suppressed_RIC] nvarchar(3)  NOT NULL
);
GO

-- Creating table 'consultant_summary'
CREATE TABLE [consultant_summary] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NOT NULL,
    [summary_txt] nvarchar(max)  NOT NULL,
    [show] bit  NOT NULL,
    [summary_descr] nvarchar(220)  NULL,
    [show_RIC] nvarchar(3)  NOT NULL
);
GO

-- Creating table 'domain'
CREATE TABLE [domain] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [domain_nm] nvarchar(100)  NOT NULL,
    [domain_descr] nvarchar(220)  NULL
);
GO

-- Creating table 'event_role'
CREATE TABLE [event_role] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [event_role_nm] nvarchar(220)  NOT NULL,
    [event_role_descr] nvarchar(220)  NULL
);
GO

-- Creating table 'exp'
CREATE TABLE [exp] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NOT NULL,
    [company_id] int  NULL,
    [project_type_id] int  NULL,
    [sow_id] int  NULL,
    [start_dt] datetime  NULL,
    [end_dt] datetime  NULL,
    [suppressed] bit  NOT NULL,
    [domain_id] int  NULL,
    [exp_descr] nvarchar(max)  NULL,
    [tags] nvarchar(220)  NULL,
    [approved] bit  NOT NULL,
    [modified_dtm] datetime  NULL,
    [modified_user_id] int  NULL
);
GO

-- Creating table 'exp_detail'
CREATE TABLE [exp_detail] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [exp_id] int  NULL,
    [order_nbr] int  NOT NULL,
    [detail_txt] nvarchar(max)  NULL,
    [suppressed] bit  NOT NULL,
    [role_id] int  NULL,
    [approved] bit  NOT NULL,
    [modified_dtm] datetime  NULL,
    [modified_user_id] int  NULL,
    [record_status] nvarchar(15)  NULL,
    [admin_approved_dtm] nvarchar(220)  NULL,
    [admin_approved_user_id] int  NULL,
    [mgr_approved_dtm] datetime  NULL,
    [mgr_approved_user_id] int  NULL
);
GO

-- Creating table 'exp_layout'
CREATE TABLE [exp_layout] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NULL,
    [sort_col1_id] int  NOT NULL,
    [sort_col2_id] int  NULL,
    [sort_col3_id] int  NULL,
    [user_nm] nvarchar(220)  NULL,
    [create_dt] datetime  NULL,
    [descr] nvarchar(220)  NULL,
    [layout_nm] nvarchar(220)  NULL,
    [sub_sect_tl_se] bit  NOT NULL,
    [sub_sect_tl_wp] bit  NOT NULL,
    [sub_sect_tl_pub] bit  NOT NULL,
    [sect_ne] bit  NOT NULL
);
GO

-- Creating table 'exp_layout_grp'
CREATE TABLE [exp_layout_grp] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [exp_layout_id] int  NOT NULL,
    [order_nbr] int  NOT NULL,
    [suppressed] bit  NOT NULL,
    [sort1_val] nvarchar(220)  NOT NULL,
    [sort2_val] nvarchar(220)  NOT NULL,
    [sort3_val] nvarchar(220)  NOT NULL,
    [sort1_nm] nvarchar(220)  NULL,
    [sort2_nm] nvarchar(220)  NULL,
    [sort3_nm] nvarchar(220)  NULL,
    [group_nm] nvarchar(220)  NOT NULL,
    [show_companies] bit  NOT NULL,
    [sort_def] nvarchar(220)  NULL
);
GO

-- Creating table 'exp_layout_grp_dtl'
CREATE TABLE [exp_layout_grp_dtl] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [exp_layout_grp_id] int  NOT NULL,
    [exp_detail_id] int  NOT NULL,
    [order_nbr] int  NULL,
    [suppressed] bit  NOT NULL,
    [detail_txt] nvarchar(max)  NULL,
    [user_nm] nvarchar(220)  NULL
);
GO

-- Creating table 'exp_sort_col'
CREATE TABLE [exp_sort_col] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [sort_col_lbl_nm] nvarchar(220)  NULL,
    [sort_col_table_nm] nvarchar(220)  NULL
);
GO

-- Creating table 'experience'
CREATE TABLE [experience] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NOT NULL,
    [sow_id] int  NOT NULL,
    [tags] nvarchar(220)  NULL,
    [order_nbr] int  NOT NULL
);
GO

-- Creating table 'experience_detail'
CREATE TABLE [experience_detail] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [experience_id] int  NULL,
    [detail_txt] nvarchar(max)  NOT NULL,
    [role_id] int  NOT NULL,
    [tags] nvarchar(220)  NULL,
    [order_nbr] int  NOT NULL
);
GO

-- Creating table 'holidays'
CREATE TABLE [holidays] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [holiday_nm] nvarchar(220)  NULL,
    [holiday_dt] datetime  NULL
);
GO

-- Creating table 'noteworthy_sow'
CREATE TABLE [noteworthy_sow] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NULL,
    [sow_id] int  NULL,
    [order_nbr] int  NOT NULL,
    [suppressed] bit  NOT NULL,
    [project_nm] nvarchar(220)  NOT NULL
);
GO

-- Creating table 'proficiency'
CREATE TABLE [proficiency] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [app_proficiency] nvarchar(220)  NOT NULL,
    [skill_proficiency] nvarchar(220)  NULL,
    [descr] nvarchar(max)  NULL
);
GO

-- Creating table 'project_type'
CREATE TABLE [project_type] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [project_type_nm] nvarchar(50)  NOT NULL,
    [project_type_descr] nvarchar(220)  NULL
);
GO

-- Creating table 'publication'
CREATE TABLE [publication] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NULL,
    [article_title] nvarchar(220)  NOT NULL,
    [publication_nm] nvarchar(220)  NOT NULL,
    [volume_info] nvarchar(220)  NOT NULL,
    [order_nbr] int  NOT NULL,
    [suppressed] bit  NOT NULL
);
GO

-- Creating table 'role'
CREATE TABLE [role] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [role_nm] nvarchar(50)  NOT NULL,
    [role_descr] nvarchar(220)  NULL
);
GO

-- Creating table 'skill'
CREATE TABLE [skill] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [skill_nm] nvarchar(70)  NOT NULL,
    [skill_descr] nvarchar(220)  NULL
);
GO

-- Creating table 'sow'
CREATE TABLE [sow] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [sow_id] nvarchar(50)  NOT NULL,
    [company_id] int  NOT NULL,
    [project_nm] nvarchar(220)  NOT NULL,
    [project_type_id] int  NOT NULL,
    [description] nvarchar(max)  NULL,
    [start_dt] datetime  NULL,
    [end_dt] datetime  NULL,
    [master_sow] int  NULL,
    [meradia_sow] bit  NOT NULL,
    [domain_id] int  NULL,
    [intro_dt] datetime  NULL,
    [intro_con] int  NULL,
    [active_sow] bit  NOT NULL
);
GO

-- Creating table 'sow_consultant'
CREATE TABLE [sow_consultant] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [sow_id] int  NOT NULL,
    [consultant_id] int  NOT NULL
);
GO

-- Creating table 'speaking_engagement'
CREATE TABLE [speaking_engagement] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NULL,
    [event_nm] nvarchar(220)  NOT NULL,
    [event_location] nvarchar(220)  NULL,
    [event_dt] datetime  NULL,
    [event_topic] nvarchar(220)  NULL,
    [order_nbr] int  NOT NULL,
    [suppressed] bit  NOT NULL,
    [event_role] int  NULL
);
GO

-- Creating table 'thought_leadership'
CREATE TABLE [thought_leadership] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NULL,
    [thought_leadership_nm] nvarchar(220)  NULL
);
GO

-- Creating table 'timeslip'
CREATE TABLE [timeslip] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NOT NULL,
    [sow_id] int  NOT NULL,
    [slip_start_dt] datetime  NOT NULL,
    [slip_phase_nm] int  NULL,
    [slip_location] nvarchar(220)  NOT NULL,
    [slip_desc] nvarchar(max)  NOT NULL,
    [slip_end_dt] datetime  NOT NULL,
    [slip_status] nvarchar(220)  NOT NULL,
    [slip_time] decimal(28,6)  NOT NULL,
    [slip_task_nm] nvarchar(220)  NULL,
    [slip_bill_status] nvarchar(220)  NULL
);
GO

-- Creating table 'timeslip_period'
CREATE TABLE [timeslip_period] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [period_name] nvarchar(20)  NOT NULL
);
GO

-- Creating table 'timeslip_phase'
CREATE TABLE [timeslip_phase] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [sow_id] int  NOT NULL,
    [slip_phase_name] nvarchar(220)  NOT NULL
);
GO

-- Creating table 'timeslip_role'
CREATE TABLE [timeslip_role] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [slip_role_nm] nvarchar(220)  NULL
);
GO

-- Creating table 'timeslip_task'
CREATE TABLE [timeslip_task] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [slip_task_nm] nvarchar(40)  NULL
);
GO

-- Creating table 'title'
CREATE TABLE [title] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [title_nm] nvarchar(50)  NOT NULL,
    [title_descr] nvarchar(220)  NULL
);
GO

-- Creating table 'white_paper'
CREATE TABLE [white_paper] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [consultant_id] int  NULL,
    [white_paper_title] nvarchar(220)  NOT NULL,
    [white_paper_dt] datetime  NOT NULL,
    [description] nvarchar(max)  NOT NULL,
    [suppressed] bit  NOT NULL,
    [order_nbr] int  NULL
);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------