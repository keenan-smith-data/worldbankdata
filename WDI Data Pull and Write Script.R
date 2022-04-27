
# WDI Data Pull and Write Script
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(WDI))

indicator_codes <- c('AG.LND.AGRI.K2','AG.LND.AGRI.ZS','AG.LND.ARBL.ZS','AG.LND.EL5M.RU.K2','AG.LND.EL5M.RU.ZS','AG.LND.EL5M.UR.K2','AG.LND.EL5M.UR.ZS','AG.LND.EL5M.ZS','AG.LND.FRST.K2','AG.LND.FRST.ZS','AG.LND.IRIG.AG.ZS','AG.LND.PRCP.MM','AG.YLD.CREL.KG','SP.POP.GROW','SP.POP.TOTL','SP.URB.GROW','SP.URB.TOTL','SP.URB.TOTL.IN.ZS','BX.KLT.DINV.WD.GD.ZS','IC.BUS.EASE.XQ','IQ.CPA.PUBS.XQ','SE.ENR.PRSC.FM.ZS','SE.PRM.CMPT.ZS','SH.DYN.MORT','SH.MED.CMHW.P3','SH.STA.MALN.ZS','SI.POV.DDAY','EG.ELC.ACCS.ZS','EG.ELC.COAL.ZS','EG.ELC.HYRO.ZS','EG.ELC.NGAS.ZS','EG.ELC.NUCL.ZS','EG.ELC.PETR.ZS','EG.ELC.RNEW.ZS','EG.ELC.RNWX.KH','EG.ELC.RNWX.ZS','EG.FEC.RNEW.ZS','EG.USE.COMM.GD.PP.KD','EG.USE.ELEC.KH.PC','EG.USE.PCAP.KG.OE','EN.ATM.CO2E.EG.ZS','EN.ATM.CO2E.GF.KT','EN.ATM.CO2E.GF.ZS','EN.ATM.CO2E.KD.GD','EN.ATM.CO2E.KT','EN.ATM.CO2E.LF.KT','EN.ATM.CO2E.LF.ZS','EN.ATM.CO2E.PC','EN.ATM.CO2E.PP.GD','EN.ATM.CO2E.PP.GD.KD','EN.ATM.CO2E.SF.KT','EN.ATM.CO2E.SF.ZS','EN.ATM.GHGO.KT.CE','EN.ATM.GHGO.ZG','EN.ATM.GHGT.KT.CE','EN.ATM.GHGT.ZG','EN.ATM.HFCG.KT.CE','EN.ATM.METH.KT.CE','EN.ATM.METH.ZG','EN.ATM.NOXE.KT.CE','EN.ATM.NOXE.ZG','EN.ATM.PFCG.KT.CE','EN.ATM.SF6G.KT.CE','EN.CLC.DRSK.XQ','EN.CLC.GHGR.MT.CE','EN.CLC.MDAT.ZS','EN.POP.EL5M.RU.ZS','EN.POP.EL5M.UR.ZS','EN.POP.EL5M.ZS','EN.URB.MCTY.TL.ZS','ER.H2O.FWTL.K3','ER.H2O.FWTL.ZS','ER.LND.PTLD.ZS','ER.MRN.PTMR.ZS','ER.PTD.TOTL.ZS','NV.AGR.TOTL.ZS')

first_year <- 2010
last_year <- 2022

environmental_wdi <- WDI(indicator = indicator_codes, start = first_year, end = last_year, extra = TRUE) |>
  as_tibble()

write_csv(environmental_wdi, "Environmental WDI.csv")

tidy_env_wdi <-
  environmental_wdi |>
  rename(agrid_land_km = AG.LND.AGRI.K2,
         agrid_land_per = AG.LND.AGRI.ZS,
         arable_per = AG.LND.ARBL.ZS,
         rural_below_5 = AG.LND.EL5M.RU.K2,
         rural_below_5_per = AG.LND.EL5M.RU.ZS,
         urban_below_5 = AG.LND.EL5M.UR.K2,
         urban_below_5_per = AG.LND.EL5M.UR.ZS,
         land_below_5_per = AG.LND.EL5M.ZS,
         forest_km = AG.LND.FRST.K2,
         forest_per = AG.LND.FRST.ZS,
         irrigated_land_per = AG.LND.IRIG.AG.ZS,
         avg_precip_mm = AG.LND.PRCP.MM,
         cereal_yield = AG.YLD.CREL.KG,
         pop_growth = SP.POP.GROW,
         pop_tot = SP.POP.TOTL,
         urban_pop_growth = SP.URB.GROW,
         urban_pop = SP.URB.TOTL,
         urban_pop_per = SP.URB.TOTL.IN.ZS,
         for_invest_per = BX.KLT.DINV.WD.GD.ZS,
         ease_business = IC.BUS.EASE.XQ,
         cpia_public_sec = IQ.CPA.PUBS.XQ,
         school_enroll = SE.ENR.PRSC.FM.ZS,
         school_complete = SE.PRM.CMPT.ZS,
         mort_rate = SH.DYN.MORT,
         health_workers = SH.MED.CMHW.P3,
         underweight_5_per = SH.STA.MALN.ZS,
         pov_headcount = SI.POV.DDAY,
         elec_access_per = EG.ELC.ACCS.ZS,
         coal_power_per = EG.ELC.COAL.ZS,
         hydro_power_per = EG.ELC.HYRO.ZS,
         gas_power_per = EG.ELC.NGAS.ZS,
         nuke_power_per = EG.ELC.NUCL.ZS,
         oil_power_per = EG.ELC.PETR.ZS,
         renew_power_per = EG.ELC.RNEW.ZS,
         renew_non_hydro = EG.ELC.RNWX.KH,
         renew_non_hydro_per = EG.ELC.RNWX.ZS,
         renew_consum_per = EG.FEC.RNEW.ZS,
         energy_use_oil_eqiv = EG.USE.COMM.GD.PP.KD,
         elec_consum_kw = EG.USE.ELEC.KH.PC,
         energy_use_oil_percap = EG.USE.PCAP.KG.OE,
         co2_intensity = EN.ATM.CO2E.EG.ZS,
         co2_gaseous_kt = EN.ATM.CO2E.GF.KT,
         co2_gaseous_per = EN.ATM.CO2E.GF.ZS,
         co2_emissions = EN.ATM.CO2E.KD.GD,
         co2_emissions_met = EN.ATM.CO2E.KT,
         co2_liquid_kt = EN.ATM.CO2E.LF.KT,
         co2_liquid_per = EN.ATM.CO2E.LF.ZS,
         co2_emmision_mt = EN.ATM.CO2E.PC,
         co2_emission_ppp = EN.ATM.CO2E.PP.GD,
         co2_emission_2017 = EN.ATM.CO2E.PP.GD.KD,
         co2_solid_kt = EN.ATM.CO2E.SF.KT,
         co2_solid_per = EN.ATM.CO2E.SF.ZS,
         other_greenhouse_mt = EN.ATM.GHGO.KT.CE,
         other_greenhouse_per = EN.ATM.GHGO.ZG,
         total_greenhouse_mt = EN.ATM.GHGT.KT.CE,
         total_greenhouse_per = EN.ATM.GHGT.ZG,
         hfc_emissions_mt = EN.ATM.HFCG.KT.CE,
         methane_mt = EN.ATM.METH.KT.CE,
         methane_per = EN.ATM.METH.ZG,
         no_emission_mt = EN.ATM.NOXE.KT.CE,
         no_emission_per = EN.ATM.NOXE.ZG,
         pfc_emission_mt = EN.ATM.PFCG.KT.CE,
         sf6_emission_mt = EN.ATM.SF6G.KT.CE,
         disaster_risk_score = EN.CLC.DRSK.XQ,
         ghg_emission_mt = EN.CLC.GHGR.MT.CE,
         dro_flood_extemp_per = EN.CLC.MDAT.ZS,
         rural_pop_below_5 = EN.POP.EL5M.RU.ZS,
         urban_pop_below_5 = EN.POP.EL5M.UR.ZS,
         pop_below_5_per = EN.POP.EL5M.ZS,
         pop_agglo_mil_per = EN.URB.MCTY.TL.ZS,
         water_withdrawals_cub = ER.H2O.FWTL.K3,
         water_withdrawals_per = ER.H2O.FWTL.ZS,
         terr_protect_per = ER.LND.PTLD.ZS,
         marine_protect_per = ER.MRN.PTMR.ZS,
         terr_mari_protect_per = ER.PTD.TOTL.ZS,
         agri_forest_fish_gdp_per = NV.AGR.TOTL.ZS)

write_csv(tidy_env_wdi, "tidy_env_wdi.csv")