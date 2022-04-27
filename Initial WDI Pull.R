suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(WDI))

indicator_codes <- c('SI.POV.DDAY','SP.DYN.LE00.IN','SP.POP.TOTL','SP.POP.GROW','SM.POP.NETM','NY.GDP.MKTP.CD','NY.GDP.PCAP.CD','NY.GDP.MKTP.KD.ZG','SL.UEM.TOTL.ZS','FP.CPI.TOTL.ZG','BX.TRF.PWKR.DT.GD.ZS','EN.ATM.CO2E.PC','AG.LND.FRST.ZS','EG.ELC.ACCS.ZS','ER.H2O.FWTL.ZS','EG.ELC.RNWX.ZS','SH.STA.SMSS.ZS','VC.IHR.PSRC.P5','GC.DOD.TOTL.GD.ZS','IT.NET.USER.ZS','SG.GEN.PARL.ZS','BX.KLT.DINV.WD.GD.ZS','SI.POV.GINI','SG.DMK.SRCR.FN.ZS', 'SI.DST.10TH.10', 'SI.DST.FRST.10', 'SP.DYN.TFRT.IN', 'SL.TLF.TOTL.FE.ZS', 'SL.TLF.CACT.MA.ZS', 'SL.TLF.CACT.FE.ZS', 'FB.BNK.CAPA.ZS', 'SP.URB.TOTL.IN.ZS', 'GB.XPD.RSDV.GD.ZS', 'SP.POP.SCIE.RD.P6', 'SP.POP.TECH.RD.P6', 'BX.GSR.ROYL.CD', 'TX.VAL.TECH.CD', 'IP.TMK.RESD', 'IP.TMK.NRES', 'IP.PAT.RESD', 'IP.PAT.NRES')

first_year <- 2010
last_year <- 2022

initial_wdi <- WDI(indicator = indicator_codes, start = first_year, end = last_year, extra = TRUE) |>
  as_tibble()

tidy_wdi <-
  initial_wdi |>
  rename(poverty_headcount = SI.POV.DDAY,
         life_exp = SP.DYN.LE00.IN,
         pop_tot = SP.POP.TOTL,
         pop_grow = SP.POP.GROW,
         migration_net = SM.POP.NETM,
         gdp = NY.GDP.MKTP.CD,
         gdp_per_cap = NY.GDP.PCAP.CD,
         gdp_grow = NY.GDP.MKTP.KD.ZG,
         unemployment = SL.UEM.TOTL.ZS,
         inflation = FP.CPI.TOTL.ZG,
         pers_remit = BX.TRF.PWKR.DT.GD.ZS,
         co2_emis = EN.ATM.CO2E.PC,
         forest_area = AG.LND.FRST.ZS,
         elec_access = EG.ELC.ACCS.ZS,
         water_withdraw = ER.H2O.FWTL.ZS,
         elec_prod_renew = EG.ELC.RNWX.ZS,
         sanitation = SH.STA.SMSS.ZS,
         int_homic = VC.IHR.PSRC.P5,
         gov_debt = GC.DOD.TOTL.GD.ZS,
         internet_use = IT.NET.USER.ZS,
         women_parlia = SG.GEN.PARL.ZS,
         foreign_invest = BX.KLT.DINV.WD.GD.ZS,
         gini = SI.POV.GINI,
         women_decisions = SG.DMK.SRCR.FN.ZS,
         highest_ten = SI.DST.10TH.10,
         lowest_ten = SI.DST.FRST.10,
         fertility_rate = SP.DYN.TFRT.IN,
         labor_force_fe = SL.TLF.TOTL.FE.ZS,
         lab_for_part_m = SL.TLF.CACT.MA.ZS,
         lab_for_part_f = SL.TLF.CACT.FE.ZS,
         bank_cap = FB.BNK.CAPA.ZS,
         urb_pop = SP.URB.TOTL.IN.ZS,
         research_exp = GB.XPD.RSDV.GD.ZS,
         res_in_rd = SP.POP.SCIE.RD.P6,
         tech_in_rd = SP.POP.TECH.RD.P6,
         charge_int_prop = BX.GSR.ROYL.CD,
         hi_tech_exports = TX.VAL.TECH.CD,
         trdmk_res = IP.TMK.RESD,
         trdmk_nres = IP.TMK.NRES,
         pat_res = IP.PAT.RESD,
         pat_nres = IP.PAT.NRES) |>
  mutate(income = as.factor(income),
         region = as.factor(region)) |>
  select(-poverty_headcount, -migration_net, -water_withdraw, -women_decisions,
         -highest_ten, -lowest_ten, -bank_cap, -longitude, -latitude, -lending,
         -iso3c, -capital, -lastupdated, -status, -gov_debt, -gini)


tidy_WDI_2010 <-
  tidy_wdi |>
  filter(year == 2010 & income != "Aggregates" & !is.na(gdp_per_cap)) |>
  select(-country, -year)

tidy_WDI_2015 <-
  tidy_wdi |>
  filter(year == 2015 & income != "Aggregates" & !is.na(gdp_per_cap)) |>
  select(-country, -year)

tidy_WDI_2018 <-
  tidy_wdi |>
  filter(year == 2018 & income != "Aggregates" & income != "Not classified" & !is.na(gdp_per_cap)) |>
  select(-country, -year)

write_csv(tidy_wdi, "tidy_WDI.csv")
write_csv(tidy_WDI_2010, "tidy_WDI_2010.csv")
write_csv(tidy_WDI_2015, "tidy_WDI_2015.csv")
write_csv(tidy_WDI_2018, "tidy_WDI_2018.csv")