!-----------------------BEGIN NOTICE -- DO NOT EDIT-----------------------
! NASA Goddard Space Flight Center
! Land Information System Framework (LISF)
! Version 7.4
!
! Copyright (c) 2022 United States Government as represented by the
! Administrator of the National Aeronautics and Space Administration.
! All Rights Reserved.
!-------------------------END NOTICE -- DO NOT EDIT-----------------------

subroutine trifctl_to_tile(n,t, pft)
  use trifctl 
  use jules53_lsmMod
  use ancil_info, only : npft_trif 
  use jules_surface_types_mod,  only: npft, nnvg, ntype
  implicit none 
  integer :: n, t, pft

  jules53_struc(n)%jules53(t)%asteps_since_triffid  =  asteps_since_triffid       ! Number of atmospheric timesteps since last call to TRIFFID
  jules53_struc(n)%jules53(t)%resp_s_acc_soilt(:,:) =  resp_s_acc_soilt(1,1,:, :)           ! Accumulated RESP_S
  jules53_struc(n)%jules53(t)%gpp                   =  gpp_gb(1)                     ! Gross primary productivity (kg C/m2/s)
  jules53_struc(n)%jules53(t)%npp                   =  npp_gb(1)                     ! Net primary productivity (kg C/m2/s)
  jules53_struc(n)%jules53(t)%resp_p                =  resp_p_gb(1)                  ! Plant respiration (kg C/m2/s)
  jules53_struc(n)%jules53(t)%resp_s_soilt(:,:)     =  resp_s_soilt(1,1,:, :)               ! Soil respiration (kg C/m2/s)
  jules53_struc(n)%jules53(t)%cv                    =  cv_gb(1)                      ! Gridbox mean vegetation carbon (kg C/m2)
  jules53_struc(n)%jules53(t)%lit_c_mn              =  lit_c_mn_gb(1)                ! Gridbox mean carbon litter (kg C/m2/360days)
  jules53_struc(n)%jules53(t)%resp_s_dr_out_gb(:,:) =  resp_s_dr_out_gb(1,:, :)        ! Mean soil respiration for driving TRIFFID (kg C/m2/360days)
  jules53_struc(n)%jules53(t)%frac_agr              =  frac_agr_gb(1)                ! Fraction of agriculture
  
  if(pft .le. npft) then
    jules53_struc(n)%jules53(t)%g_leaf_acc(pft)        =  g_leaf_acc_pft(1, pft)           ! Accumulated leaf turnover rate
    jules53_struc(n)%jules53(t)%g_leaf_phen_acc(pft)   =  g_leaf_phen_acc_pft(1, pft)      ! Accumulated leaf turnover rate including phenology
    jules53_struc(n)%jules53(t)%g_leaf(pft)            =  g_leaf_pft(1, pft)               ! Leaf turnover rate (/360days)
    jules53_struc(n)%jules53(t)%g_leaf_phen(pft)       =  g_leaf_phen_pft(1, pft)          ! Mean leaf turnover rate over phenology period(/360days)
    jules53_struc(n)%jules53(t)%resp_p_ft(pft)         =  resp_p_pft(1, pft)            ! Plant respiration on PFTs (kg C/m2/s)
    jules53_struc(n)%jules53(t)%gpp_ft(pft)            =  gpp_pft(1, pft)               ! Gross primary productivity on PFTs (kg C/m2/s)
    jules53_struc(n)%jules53(t)%npp_ft(pft)            =  npp_pft(1, pft)               ! Net primary productivity on PFTs (kg C/m2/s)
    jules53_struc(n)%jules53(t)%resp_w_ft(pft)         =  resp_w_pft(1, pft)            ! Wood maintenance respiration (kg C/m2/s)
    jules53_struc(n)%jules53(t)%lai_phen(pft)          =  lai_phen_pft(1, pft)             ! LAI of PFTs after phenology. Required as separate variable for top-level argument list matching with VEG_IC2A
    jules53_struc(n)%jules53(t)%c_veg(pft)             =  c_veg_pft(1, pft)                ! Total carbon content of the vegetation (kg C/m2)
    jules53_struc(n)%jules53(t)%g_leaf_day(pft)        =  g_leaf_day_pft(1, pft)           ! Mean leaf turnover rate for input to PHENOL (/360days)
    jules53_struc(n)%jules53(t)%g_leaf_dr_out(pft)     =  g_leaf_dr_out_pft(1, pft)        ! Mean leaf turnover rate for driving TRIFFID (/360days)
    jules53_struc(n)%jules53(t)%lit_c(pft)             =  lit_c_pft(1, pft)                ! Carbon Litter (kg C/m2/360days)
    jules53_struc(n)%jules53(t)%npp_dr_out(pft)        =  npp_dr_out_pft(1, pft)           ! Mean NPP for driving TRIFFID (kg C/m2/360days)
    jules53_struc(n)%jules53(t)%resp_w_dr_out(pft)     =  resp_w_dr_out_pft(1, pft)        ! Mean wood respiration for driving TRIFFID (kg C/m2/360days)
  endif

  if(npft_trif>1 .and. pft .le. npft_trif) then
    jules53_struc(n)%jules53(t)%npp_ft_acc(pft)        =  npp_acc_pft(1, pft)           ! Accumulated NPP_FT
    jules53_struc(n)%jules53(t)%resp_w_ft_acc(pft)     =  resp_w_acc_pft(1, pft)        ! Accum RESP_W_FT
  else
    jules53_struc(n)%jules53(t)%npp_ft_acc(:)          =  npp_acc_pft(1, :)           ! Accumulated NPP_FT
    jules53_struc(n)%jules53(t)%resp_w_ft_acc(:)       =  resp_w_acc_pft(1, :)        ! Accum RESP_W_FT
  endif

end subroutine trifctl_to_tile 
