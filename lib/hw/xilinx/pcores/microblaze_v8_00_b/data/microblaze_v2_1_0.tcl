###############################################################################
##
## (c) Copyright 1995-2010 Xilinx, Inc. All rights reserved.
##
## This file contains confidential and proprietary information
## of Xilinx, Inc. and is protected under U.S. and 
## international copyright and other intellectual property
## laws.
##
## DISCLAIMER
## This disclaimer is not a license and does not grant any
## rights to the materials distributed herewith. Except as
## otherwise provided in a valid license issued to you by
## Xilinx, and to the maximum extent permitted by applicable
## law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
## WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
## AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
## BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
## INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
## (2) Xilinx shall not be liable (whether in contract or tort,
## including negligence, or under any other theory of
## liability) for any loss or damage of any kind or nature
## related to, arising under or in connection with these
## materials, including for any direct, or any indirect,
## special, incidental, or consequential loss or damage
## (including loss of data, profits, goodwill, or any type of
## loss or damage suffered as a result of any action brought
## by a third party) even if such damage or loss was
## reasonably foreseeable or Xilinx had been advised of the
## possibility of the same.
##
## CRITICAL APPLICATIONS
## Xilinx products are not designed or intended to be fail-
## safe, or for use in any application requiring fail-safe
## performance, such as life-support or safety devices or
## systems, Class III medical devices, nuclear facilities,
## applications related to the deployment of airbags, or any
## other applications that could lead to death, personal
## injury, or severe property or environmental damage
## (individually and collectively, "Critical
## Applications"). Customer assumes the sole risk and
## liability of any use of Xilinx products in Critical
## Applications, subject only to applicable laws and
## regulations governing limitations on product liability.
##
## THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
## PART OF THIS FILE AT ALL TIMES.
##
###############################################################################
##
## microblaze_v2_1_0.tcl
##
###############################################################################

#***--------------------------------***------------------------------------***
#
# 		         SYSLEVEL_DRC_PROC
#
#***--------------------------------***------------------------------------***

# Output warning message
proc warning { mhsinst message } {
   puts -nonewline "WARNING ****************************************************************"
   puts -nonewline "WARNING **             MicroBlaze - [xget_hw_name $mhsinst]"
   puts -nonewline "WARNING ****************************************************************"

   set index     0
   set linefirst 0
   set linelast  0
   set length    [string length $message]
   while {$index < $length} {
     if {[string index $message $index] == " "} {
       set linelast $index
     }
     if {[expr $index - $linefirst] >= 61} {
       puts -nonewline "WARNING ** [string range $message $linefirst $linelast]"
       set linefirst [expr $linelast + 1]
     }
     incr index
     if {($index == $length) && ($linefirst < $length)} {
       puts -nonewline "WARNING ** [string range $message $linefirst end]"
     }
   }

   puts "WARNING ****************************************************************"
}

# Determine if signal is connected by finding sink or source of signal
proc is_connected { mhsinst signal } {
   set mhs_handle [xget_hw_parent_handle $mhsinst]
   if { [llength $mhs_handle] > 0} {
     set master_con [xget_hw_port_value $mhsinst $signal]
     if { [llength $master_con] > 0} {
       set master_sink   [xget_connected_ports_handle $mhs_handle $master_con "SINK"]
       set master_source [xget_connected_ports_handle $mhs_handle $master_con "SOURCE"]
       if {[llength $master_sink] + [llength $master_source] > 1} {
         return 1
       }
     }
   }
   return 0
}

# Determine if bus is connected
proc bus_is_connected { mhsinst bus } {
   set bus_handle [xget_hw_busif_handle $mhsinst $bus]
   if {$bus_handle == ""} {
     return 0
   }
   set bus_name [xget_hw_value $bus_handle]
   if {$bus_name == ""} {
     return 0
   }
   set bus_busip_handle [xget_connected_p2p_busif_handle $bus_handle ]
   if {$bus_busip_handle == ""} {
     return 0
   }
   set bus_busip_name [xget_hw_value $bus_busip_handle]
   if {$bus_busip_name == ""} {
     return 0
   }
   return 1
}

# Check IXCL interface to make sure it is connected and PLB addressable
proc check_icache_bus {mhsinst} {
   set retval 0
   set connected 0
   set mhs_handle [xget_hw_parent_handle $mhsinst]

   set icache_base [xformat_address_string [xget_hw_parameter_value $mhsinst "C_ICACHE_BASEADDR"]]
   set icache_high [xformat_address_string [xget_hw_parameter_value $mhsinst "C_ICACHE_HIGHADDR"]]

   set inter_conn     [xget_hw_parameter_value $mhsinst "C_INTERCONNECT"]
   
   if { $inter_conn == 1 } {
      # Check if connected with the IXCL bus
      set icache_bus_name "IXCL"
      set ixcl_handle [xget_hw_busif_handle $mhsinst $icache_bus_name]
   
      set ixcl_name ""
      if {$ixcl_handle != ""} {
         set ixcl_name [xget_hw_value $ixcl_handle]
      }
   
      # Needed to check for ixcl_name to establish whether IXCL is connected
      # ixcl_handle has a value whether connected or not
      if {$ixcl_name != ""} {
         set ixcl_busip_handle  [xget_connected_p2p_busif_handle $ixcl_handle ]
   
         set ixcl_busip_name ""
         if {$ixcl_busip_handle != ""} {
            set ixcl_busip_name [xget_hw_value $ixcl_busip_handle]
         }
   
         if {$ixcl_busip_name != ""} {
            # puts "IXCL is connected."
            # puts "ixcl_busip_name: $ixcl_busip_name"
            # ixcl_busip_name: ixcl
   
            set ivalid 0
            set ip_handle [xget_hw_parent_handle $ixcl_busip_handle]
            set addrlist [xget_addr_values_list_for_ipinst $ip_handle]
            set addrlen [llength $addrlist]
   
            ######################
            # Check addresses
            ######################
            set i 0
            set addrsetlist {}
            while {$i < $addrlen} {
               lappend addrsetlist [list [lindex $addrlist $i] [lindex $addrlist [expr $i + 1]]]
               set i [expr $i + 2]
            }
            set addrsetlist [lsort -index 0 $addrsetlist]
            set addrsetlen [llength $addrsetlist]
   
            set i 0
            set icache_base_index -1
            set icache_high_index -1
            while {$i < $addrsetlen} {
               set base [lindex [lindex $addrsetlist $i] 0]
               set high [lindex [lindex $addrsetlist $i] 1]
   
               if {($icache_base >= $base) && ($icache_base <= $high)} {
                 set icache_base_index $i
               }
               if {($icache_high >= $base) && ($icache_high <= $high)} {
                 set icache_high_index $i
               }
               incr i
            }
   
            if {($icache_base_index != -1) && ($icache_high_index != -1)} {
               # Cache address range within checked addresses - valid
               set ivalid 1
               set connected 1
   
               # Check and warn about address holes
               set i $icache_base_index
               while {$i <= $icache_high_index} {
                  set base [lindex [lindex $addrsetlist $i] 0]
                  if {($i != $icache_base_index) && ($prevhigh + 1 < $base)} {
                     set busip_name [xget_hw_name $ip_handle]
                     warning $mhsinst "ICACHE address space \[$icache_base:$icache_high\] contains an area without assigned addresses in IP \"$busip_name\" on bus \"$ixcl_name\"."
                  }
                  set prevhigh [lindex [lindex $addrsetlist $i] 1]
                  incr i
               }
            }
   
            if {! $ivalid} {
               set busip_name [xget_hw_name $ip_handle]
               error "ICACHE address space \[$icache_base:$icache_high\] does not match IP \"$busip_name\" on bus \"$ixcl_name\"" "" "mdt_error"
               set retval [expr $retval + 1]
            }
   
            ######################
            # Check line length
            ######################
   
            set icache_len [xget_hw_parameter_value $mhsinst "C_ICACHE_LINE_LEN"]
            # icache_len: 4
   
            set busip_name [xget_hw_name $ip_handle]
            # busip_name: SDRAM_8Mx32
   
            set busip_busname ""
            if {$ixcl_busip_handle != ""} {
               set busip_busname [xget_hw_name $ixcl_busip_handle]
            }
            # busip_busname: MCH0-MCH3 or XCL0-XCL7,XCL0_B-XCL7_B (for MPMC)
   
            set busip_param ""
            if {$busip_busname == "MCH0"} {
               set busip_param "C_XCL0_LINESIZE";
            } elseif {$busip_busname == "MCH1"} {
               set busip_param "C_XCL1_LINESIZE";
            } elseif {$busip_busname == "MCH2"} {
               set busip_param "C_XCL2_LINESIZE";
            } elseif {$busip_busname == "MCH3"} {
               set busip_param "C_XCL3_LINESIZE";
   
            } elseif {[regexp {XCL[0-7]$} $busip_busname match]} {
               set busip_param "C_${match}_LINESIZE"
            } elseif {[regexp {XCL[0-7]_B} $busip_busname match]} {
               set busip_param "C_${match}_LINESIZE"
   
            } else {
               warning $mhsinst "Unknown XCL bus \"$busip_busname\" on IP \"$busip_name\". Unable to verify line length."
            }
            if {$busip_param != ""} {
               set busip_len [xget_hw_parameter_value $ip_handle $busip_param]
               # puts "busip_len: $busip_len"
               # busip_len: 4
               if {$busip_len != ""} {
                  if {$busip_len != $icache_len} {
                     error "IP \"$busip_name\" line length $busip_param \"$busip_len\" does not match MicroBlaze line length C_ICACHE_LINE_LEN \"$icache_len\"" "" "mdt_error"
                     set retval [expr $retval + 1]
                  }
               } else {
                  warning $mhsinst "Unable to determine line length for IP \"$busip_name\" on bus \"$busip_busname\" due to being unable to find parameter \"$busip_param\"."
               }
            }
   
            #####################################################################
            # Check that IXCL2 icache interface is connected to an IP core that
            # can handle it: mpmc 5.00.a or higher, xps_mch_emc 3.00.a or higher
            #####################################################################
   
            set icache_interface [xget_hw_parameter_value $mhsinst "C_ICACHE_INTERFACE"]
            if {$icache_interface == 1} {
               set busip_value [xget_hw_value $ip_handle]
               if {$busip_value == "mpmc"} {
                  set busip_version [xget_hw_parameter_value $ip_handle "HW_VER"]
                  regexp {([0-9]*)\.([0-9]*)\.([A-Za-z])} $busip_version match major minor patch
                  if {$major < 5} {
                     error "MicroBlaze is configured to use the IXCL2 protocol, which requires MPMC v5.00.a or higher. Please change version of instantiated MPMC." "" "mdt_error"
                     set retval [expr $retval + 1]
                  }
               } elseif {$busip_value == "xps_mch_emc"} {
                  set busip_version [xget_hw_parameter_value $ip_handle "HW_VER"]
                  regexp {([0-9]*)\.([0-9]*)\.([A-Za-z])} $busip_version match major minor patch
                  if {$major < 3} {
                     error "MicroBlaze is configured to use the IXCL2 protocol, which requires XPS_MCH_EMC v3.00.a or higher. Please change version of instantiated XPS_MCH_EMC." "" "mdt_error"
                     set retval [expr $retval + 1]
                  }
               } else {
                  warning $mhsinst "MicroBlaze is configured to use the IXCL2 protocol. Please ensure that the interface implementated in $busip_value can handle this protocol."
               }
            }
         }
      }
   } else {
      # Check if connected with the M_AXI_IC bus
      set icache_bus_name "M_AXI_IC"
      set icaxi_handle [xget_hw_busif_handle $mhsinst $icache_bus_name]
   
      set icaxi_name ""
      if {$icaxi_handle != ""} {
         set icaxi_name [xget_hw_value $icaxi_handle]
      }
   
      # Needed to check for icaxi_name to establish whether M_AXI_IC is connected
      # icaxi_handle has a value whether connected or not
      if {$icaxi_name != ""} {
         set icaxi_busip_handle  [xget_connected_p2p_busif_handle $icaxi_handle ]
   
         set icaxi_busip_name ""
         if {$icaxi_busip_handle != ""} {
            set icaxi_busip_name [xget_hw_value $icaxi_busip_handle]
         }
   
         if {$icaxi_busip_name != ""} {
               set connected 1
         }
      }
   }

   if {! $connected} {
      error "The ICACHE $icache_bus_name bus interface is unconnected. The MicroBlaze processor (version v5.00.a and higher) requires that the bus interface is connected when the ICACHE is enabled." "" "mdt_error"
      set retval [expr $retval + 1]
   }

   return $retval
}


# Check DXCL interface to make sure it is connected and PLB addressable
proc check_dcache_bus {mhsinst} {
   set retval 0
   set connected 0
   set mhs_handle [xget_hw_parent_handle $mhsinst]

   set dcache_base [xformat_address_string [xget_hw_parameter_value $mhsinst "C_DCACHE_BASEADDR"]]
   set dcache_high [xformat_address_string [xget_hw_parameter_value $mhsinst "C_DCACHE_HIGHADDR"]]

   set inter_conn     [xget_hw_parameter_value $mhsinst "C_INTERCONNECT"]
   
   if { $inter_conn == 1 } {
      # Check if connected with the DXCL bus
      set dcache_bus_name "DXCL"
      set dxcl_handle [xget_hw_busif_handle $mhsinst $dcache_bus_name]
   
      set dxcl_name ""
      if {$dxcl_handle != ""} {
         set dxcl_name [xget_hw_value $dxcl_handle]
      }
   
      # Needed to check for dxcl_name to establish whether DXCL is connected
      # dxcl_handle has a value whether connected or not
      if {$dxcl_name != ""} {
         set dxcl_busip_handle  [xget_connected_p2p_busif_handle $dxcl_handle ]
   
         set dxcl_busip_name ""
         if {$dxcl_busip_handle != ""} {
            set dxcl_busip_name [xget_hw_value $dxcl_busip_handle]
         }
   
         if {$dxcl_busip_name != ""} {
            # puts "DXCL is connected."
            set dvalid 0
            set ip_handle [xget_hw_parent_handle $dxcl_busip_handle]
            set addrlist [xget_addr_values_list_for_ipinst $ip_handle]
            set addrlen [llength $addrlist]
   
            ######################
            # Check addresses
            ######################
            set i 0
            set addrsetlist {}
            while {$i < $addrlen} {
               lappend addrsetlist [list [lindex $addrlist $i] [lindex $addrlist [expr $i + 1]]]
               set i [expr $i + 2]
            }
            set addrsetlist [lsort -index 0 $addrsetlist]
            set addrsetlen [llength $addrsetlist]
   
            set i 0
            set dcache_base_index -1
            set dcache_high_index -1
            while {$i < $addrsetlen} {
               set base [lindex [lindex $addrsetlist $i] 0]
               set high [lindex [lindex $addrsetlist $i] 1]
   
               if {($dcache_base >= $base) && ($dcache_base <= $high)} {
                 set dcache_base_index $i
               }
               if {($dcache_high >= $base) && ($dcache_high <= $high)} {
                 set dcache_high_index $i
               }
               incr i
            }
   
            if {($dcache_base_index != -1) && ($dcache_high_index != -1)} {
               # Cache address range within checked addresses - valid
               set dvalid 1
               set connected 1
   
               # Check and warn about address holes
               set i $dcache_base_index
               while {$i <= $dcache_high_index} {
                  set base [lindex [lindex $addrsetlist $i] 0]
                  if {($i != $dcache_base_index) && ($prevhigh + 1 < $base)} {
                     set busip_name [xget_hw_name $ip_handle]
                     warning $mhsinst "DCACHE address space \[$dcache_base:$dcache_high\] contains an area without assigned addresses in IP \"$busip_name\" on bus \"$dxcl_name\"."
                  }
                  set prevhigh [lindex [lindex $addrsetlist $i] 1]
                  incr i
               }
            }
   
            if {! $dvalid} {
               set busip_name [xget_hw_name $ip_handle]
               error "DCACHE address space \[$dcache_base:$dcache_high\] does not match IP \"$busip_name\" on bus \"$dxcl_name\"" "" "mdt_error"
               set retval [expr $retval + 1]
            }
   
            ######################
            # Check line length
            ######################
   
            set dcache_len [xget_hw_parameter_value $mhsinst "C_DCACHE_LINE_LEN"]
            # dcache_len: 4
   
            set busip_name [xget_hw_name $ip_handle]
            # busip_name: SDRAM_8Mx32
   
            set busip_busname ""
            if {$dxcl_busip_handle != ""} {
               set busip_busname [xget_hw_name $dxcl_busip_handle]
            }
            # busip_busname: MCH0-MCH3 or XCL0-XCL7,XCL0_B-XCL7_B (for MPMC)
   
            set busip_param ""
            if {$busip_busname == "MCH0"} {
               set busip_param "C_XCL0_LINESIZE";
            } elseif {$busip_busname == "MCH1"} {
               set busip_param "C_XCL1_LINESIZE";
            } elseif {$busip_busname == "MCH2"} {
               set busip_param "C_XCL2_LINESIZE";
            } elseif {$busip_busname == "MCH3"} {
               set busip_param "C_XCL3_LINESIZE";
   
            } elseif {[regexp {XCL[0-7]$} $busip_busname match]} {
               set busip_param "C_${match}_LINESIZE"
            } elseif {[regexp {XCL[0-7]_B} $busip_busname match]} {
               set busip_param "C_${match}_LINESIZE"
   
            } else {
               warning $mhsinst "Unknown XCL bus \"$busip_busname\" on IP \"$busip_name\". Unable to verify line length."
            }
            if {$busip_param != ""} {
               set busip_len [xget_hw_parameter_value $ip_handle $busip_param]
               # puts "busip_len: $busip_len"
               # busip_len: 4
               if {$busip_len != ""} {
                  if {$busip_len != $dcache_len} {
                     error "IP \"$busip_name\" line length $busip_param \"$busip_len\" does not match MicroBlaze line length C_DCACHE_LINE_LEN \"$dcache_len\"" "" "mdt_error"
                     set retval [expr $retval + 1]
                  }
               } else {
                  warning $mhsinst "Unable to determine line length for IP \"$busip_name\" on bus \"$busip_busname\" due to being unable to find parameter \"$busip_param\"."
               }
            }
   
            #####################################################################
            # Check that DXCL dcache interface is not used with write-back cache
            #####################################################################
   
            set dcache_interface [xget_hw_parameter_value $mhsinst "C_DCACHE_INTERFACE"]
            set dcache_use_writeback [xget_hw_parameter_value $mhsinst "C_DCACHE_USE_WRITEBACK"]
            if {$dcache_use_writeback} {
               if {$dcache_interface == 0} {
                  error "MicroBlaze requires that the DXCL2 protocol is used when write-back data cache is enabled. To correct this error, change C_DCACHE_INTERFACE to 1 (DXCL2)." "" "mdt_error"
                  set retval [expr $retval + 1]
               }
            }
   
            #####################################################################
            # Check that DXCL2 dcache interface is connected to an IP core that
            # can handle it: mpmc 5.00.a or higher, xps_mch_emc 3.00.a or higher
            #####################################################################
   
            if {$dcache_interface == 1} {
               set busip_value [xget_hw_value $ip_handle]
               if {$busip_value == "mpmc"} {
                  set busip_version [xget_hw_parameter_value $ip_handle "HW_VER"]
                  regexp {([0-9]*)\.([0-9]*)\.([A-Za-z])} $busip_version match major minor patch
                  if {$major < 5} {
                     error "MicroBlaze is configured to use the DXCL2 protocol, which requires MPMC v5.00.a or higher. Please change version of instantiated MPMC." "" "mdt_error"
                     set retval [expr $retval + 1]
                  }
               } elseif {$busip_value == "xps_mch_emc"} {
                  set busip_version [xget_hw_parameter_value $ip_handle "HW_VER"]
                  regexp {([0-9]*)\.([0-9]*)\.([A-Za-z])} $busip_version match major minor patch
                  if {$major < 3} {
                     error "MicroBlaze is configured to use the DXCL2 protocol, which requires XPS_MCH_EMC v3.00.a or higher. Please change version of instantiated XPS_MCH_EMC." "" "mdt_error"
                     set retval [expr $retval + 1]
                  }
               } else {
                  warning $mhsinst "MicroBlaze is configured to use the DXCL2 protocol. Please ensure that the interface implementated in $busip_value can handle this protocol."
               }
            }
         }
      }
   } else {
      # Check if connected with the M_AXI_DC bus
      set dcache_bus_name "M_AXI_DC"
      set dcaxi_handle [xget_hw_busif_handle $mhsinst $dcache_bus_name]
   
      set dcaxi_name ""
      if {$dcaxi_handle != ""} {
         set dcaxi_name [xget_hw_value $dcaxi_handle]
      }
   
      # Needed to check for dcaxi_name to establish whether M_AXI_DC is connected
      # dcaxi_handle has a value whether connected or not
      if {$dcaxi_name != ""} {
         set dcaxi_busip_handle  [xget_connected_p2p_busif_handle $dcaxi_handle ]
   
         set dcaxi_busip_name ""
         if {$dcaxi_busip_handle != ""} {
            set dcaxi_busip_name [xget_hw_value $dcaxi_busip_handle]
         }
   
         if {$dcaxi_busip_name != ""} {
               set connected 1
         }
      }
   }

   if {! $connected} {
      error "The DCACHE $dcache_bus_name bus interface is unconnected. The MicroBlaze processor (version v5.00.a and higher) requires that the bus interface is connected when the DCACHE is enabled." "" "mdt_error"
      set retval [expr $retval + 1]
   }

   return $retval
}

#
#
proc check_syslevel_settings { mhsinst } {

    # To allow custom LMB IP please change this variable to 1
    set IGNORE_CUSTOM_LMB_IP_ERROR 0

    set retval 0

    ####################################################################
    # Check connected LMB_BRAM is v2.00a or higher. This is necessary
    # because of different pipelining of writes in the 5 stage pipeline
    ####################################################################
    set mhs_handle [xget_hw_parent_handle $mhsinst]

    # First find the DLMB bus instance...
    set master_addrstrobe_con [xget_hw_port_value $mhsinst "D_AS"] 
    if { [llength $master_addrstrobe_con] > 0} {
	set master_addrstrobe_sinks [xget_connected_ports_handle $mhs_handle $master_addrstrobe_con "SINK"]
	if {[llength $master_addrstrobe_sinks] == 0} {
	    error "BUS_INTERFACE DLMB is unconnected." "" "mdt_error"
	    incr retval
	}
	foreach master_addrstrobe_sink $master_addrstrobe_sinks {
	    set bus_handle [xget_hw_parent_handle $master_addrstrobe_sink]
	    if {[xget_hw_value $bus_handle] == "lmb_v10"} {
		# ...then find the LMB BRAM controller instance...
		set slave_addrstrobe_con [xget_hw_port_value $bus_handle "LMB_AddrStrobe"]
		if { [llength $slave_addrstrobe_con] == 0} {
		    error "BUS_INTERFACE SLMB is unconnected. The core LMB_V10 v1.00a requires that this be connected to an LMB BRAM controller" "" "mdt_error"
		    incr retval
		}
		set slave_addrstrobe_sink [xget_connected_ports_handle $mhs_handle $slave_addrstrobe_con "SINK"]
		if {[llength $slave_addrstrobe_sink] == 0} {
		    error "BUS_INTERFACE SLMB is unconnected. The core LMB_V10 v1.00a requires that this be connected to an LMB BRAM controller" "" "mdt_error"
		    incr retval
		}

		# ...loop in case of multiple memory controllers...
		foreach lmb_slave_AS_port $slave_addrstrobe_sink {
		    set lmb_slave_handle [xget_hw_parent_handle $lmb_slave_AS_port]

		    #...check that it really is an LMB BRAM controller...
		    set lmb_slave_name [xget_hw_value $lmb_slave_handle]
		    if {($lmb_slave_name != "lmb_bram_if_cntlr")} {
			if {$IGNORE_CUSTOM_LMB_IP_ERROR == 0} {
			    error "Detected non-standard LMB slave: $lmb_slave_name. XILINX does not support using the LMB interface with any IP except LMB_BRAM_IF_CNTLR. Other IP may severely limit the processor maximum frequency. To use a non-standard LMB slave, this error check can be disabled by setting IGNORE_CUSTOM_LMB_IP_ERROR to 1 in the MicroBlaze TCL file." "" "mdt_error"
			    incr retval
			}
		    } else {
			#...finally check the LMB BRAM controller version
			set lmb_bram_if_cntlr_version [xget_hw_parameter_value $lmb_slave_handle "HW_VER"]
			regexp {([0-9]*)\.([0-9]*)\.([A-Za-z])} $lmb_bram_if_cntlr_version match major minor patch
			if {($major < 2) || (($major == 2) && ($minor < 10))} {
			    # prior to version 2.10.a
			    error "The MicroBlaze processor version v7.00.a and higher requires the use of LMB_BRAM_IF_CNTLR v2.10.a or higher. Please change version of instantiated LMB BRAM controller." "" "mdt_error"
			    incr retval
			}
		    }
		}
	    }
	}
    }

    ## The ILMB interface is don't care since it does not perform write operations, but we'll force it to use the new controller for consistency
    set master_addrstrobe_con [xget_hw_port_value $mhsinst "I_AS"] 
    if { [llength $master_addrstrobe_con] > 0} {
	set master_addrstrobe_sinks [xget_connected_ports_handle $mhs_handle $master_addrstrobe_con "SINK"]
	foreach master_addrstrobe_sink $master_addrstrobe_sinks {
	    set bus_handle [xget_hw_parent_handle $master_addrstrobe_sink]
	    if {[xget_hw_value $bus_handle] == "lmb_v10"} {
		if {[llength $master_addrstrobe_sink] == 0} {
		    error "BUS_INTERFACE ILMB is unconnected." "" "mdt_error"
		    incr retval
		}
		set bus_handle [xget_hw_parent_handle $master_addrstrobe_sink]

		# ...then find the LMB BRAM controller instance...
		set slave_addrstrobe_con [xget_hw_port_value $bus_handle "LMB_AddrStrobe"]
		if { [llength $slave_addrstrobe_con] == 0} {
		    error "BUS_INTERFACE SLMB is unconnected. The core LMB_V10 requires that this be connected to an LMB BRAM controller" "" "mdt_error"
		    incr retval
		}
		set slave_addrstrobe_sink [xget_connected_ports_handle $mhs_handle $slave_addrstrobe_con "SINK"]
		if {[llength $slave_addrstrobe_sink] == 0} {
		    error "BUS_INTERFACE SLMB is unconnected. The core LMB_V10 requires that this be connected to an LMB BRAM controller" "" "mdt_error"
		    incr retval
		}
		# ...loop in case of multiple memory controllers...
		foreach lmb_slave_AS_port $slave_addrstrobe_sink {
		    set lmb_slave_handle [xget_hw_parent_handle $lmb_slave_AS_port]

		    #...check that it really is an LMB BRAM controller...
		    set lmb_slave_name [xget_hw_value $lmb_slave_handle]
		    if {($lmb_slave_name != "lmb_bram_if_cntlr")} {
			if {$IGNORE_CUSTOM_LMB_IP_ERROR == 0} {
			    error "Detected non-standard LMB slave: $lmb_slave_name. XILINX does not support using the LMB interface with any IP except LMB_BRAM_IF_CNTLR. Other IP may severely limit the processor maximum frequency. To use a non-standard LMB slave, this error check can be disabled by setting IGNORE_CUSTOM_LMB_IP_ERROR to 1 in the MicroBlaze TCL file."
			    incr retval
			}
		    } else {
			#...finally check the LMB BRAM controller version
			set lmb_bram_if_cntlr_version [xget_hw_parameter_value $lmb_slave_handle "HW_VER"]
			if {($lmb_bram_if_cntlr_version == "1.00.b")} {
			    error "The MicroBlaze processor version v5.00.a and higher requires the use of LMB_BRAM_IF_CNTLR v2.00.a or higher. Please change version of instantiated MicroBlaze processor or LMB BRAM controller." "" "mdt_error"
			    incr retval
			}
		    }
		}
	    }
	}
    }


    ####################################################################
    # Check reset connections
    ####################################################################
    if {[is_connected $mhsinst "RESET"   ] == 0 &&
        [is_connected $mhsinst "MB_RESET"] == 0 } {
      error "The RESET or MB_RESET signal is not connected. MicroBlaze cannot work without a correct reset input." "" "mdt_error"
      incr retval
    }


    ####################################################################
    # Check caches and FSL 
    ####################################################################
    set use_icache [xget_hw_parameter_value $mhsinst "C_USE_ICACHE"]
    set use_dcache [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]

    if {$use_icache == "1"} {
       # puts "ICACHE is enabled"
       set reti [check_icache_bus $mhsinst]
       set retval [expr $retval + $reti]
    }

    if {$use_dcache == "1"} {
       # puts "DCACHE is enabled"
       set retd [check_dcache_bus $mhsinst]
       set retval [expr $retval + $retd]
    }


    ####################################################################
    # Check debug connections
    ####################################################################
    set debug_enabled [xget_hw_parameter_value $mhsinst "C_DEBUG_ENABLED"]
    if {$debug_enabled == 1} {
      if {[bus_is_connected $mhsinst "DEBUG"] == 0} {
        set unconnected_signals {}
        set signals {"Dbg_Capture" "Dbg_Clk" "Dbg_Reg_En" "Dbg_Shift" "Dbg_TDI" "Dbg_TDO" "Dbg_Update" "Debug_Rst"}
        foreach signal $signals {
          if {[is_connected $mhsinst $signal] == 0} {
            lappend unconnected_signals $signal
          }
        }
        set unconnected_count [llength $unconnected_signals]
        if {$unconnected_count > 0} {
          set first_signals [join [lrange $unconnected_signals 0 [expr $unconnected_count - 2]] {, }]
          set last_signal [lindex $unconnected_signals end]
          if {$unconnected_count == 1} {
            set unconnected_msg "The signal $last_signal is not connected"
          } else {
            set unconnected_msg "The signals $first_signals and $last_signal are not connected"
          }
          error "The Debug interface is not correctly connected. $unconnected_msg. To use the interface the bus or all signals must be connected to an MDM." "" "mdt_error"
          incr retval
        }
      }
    }

    ####################################################################
    # Check exception usage
    ####################################################################
    set d_plb              [syslevel_update_d_plb [xget_hw_parameter_handle $mhsinst "C_D_PLB"]]
    set i_plb              [syslevel_update_i_plb [xget_hw_parameter_handle $mhsinst "C_I_PLB"]]
    set interconnect       [xget_hw_parameter_value $mhsinst "C_INTERCONNECT"]

    set dplb_bus_exception [xget_hw_parameter_value $mhsinst "C_DPLB_BUS_EXCEPTION"]
    if {$interconnect == 1 && $d_plb == 0 && $dplb_bus_exception == 1} {
      warning $mhsinst "DPLB Bus Exception is enabled, but cannot occur since DPLB is not used. Consider disabling the exception, to avoid unnecessary logic."
    }

    set iplb_bus_exception [xget_hw_parameter_value $mhsinst "C_IPLB_BUS_EXCEPTION"]
    if {$interconnect == 1 && $i_plb == 0 && $iplb_bus_exception == 1} {
      warning $mhsinst "IPLB Bus Exception is enabled, but cannot occur since IPLB is not used. Consider disabling the exception, to avoid unnecessary logic."
    }

    return $retval
}

#***--------------------------------***------------------------------------***
#
#			     IPLEVEL_DRC_PROC
#
#***--------------------------------***------------------------------------***

proc check_cache {mhsinst baseaddr highaddr} {
   set retval 0
   set cache_base [xformat_address_string [xget_hw_parameter_value $mhsinst $baseaddr]]
   set cache_high [xformat_address_string [xget_hw_parameter_value $mhsinst $highaddr]]

   # TCL does not do unsigned
   if {$cache_high < 0} {
      set cache_high [expr $cache_high & 0x7fffffff]
      if {$cache_base < 0} {
        # Strip out MSB in both of them
        set cache_base [expr $cache_base & 0x7fffffff]
      }
   }

   # MSB is high, and MSB was not high in cache_high
   if {$cache_base < 0} {
      error "$baseaddr >= $highaddr: $cache_base >= $cache_high" "" "mdt_error"
      set retval [expr $retval + 1]
   } elseif {$cache_base >= $cache_high} {
      error "$baseaddr >= $highaddr: $cache_base >= $cache_high" "" "mdt_error"
      set retval [expr $retval + 1]
   }

   # Check that the cacheable segment size must be 2**N, where N is a positive integer.
   # Check that the range specified by C_DCACHE_BASEADDR and C_DCACHE_HIGHADDR must comprise a
   # complete power-of-two range, such that range = 2**N and the N least significant bits of
   # C_DCACHE_BASEADDR must be zero.
   if {$retval == 0} {
      set cache_base [xformat_address_string [xget_hw_parameter_value $mhsinst $baseaddr]]
      set cache_high [xformat_address_string [xget_hw_parameter_value $mhsinst $highaddr]]

      if {$cache_base != 0 && $cache_high != 0xffffffff} {
         set power_of_two 1
         set size [expr $cache_high - $cache_base + 1]
         set n 0
         while {$n < 31} {
            if {$power_of_two == $size} { break }
            set power_of_two [expr 2 * $power_of_two]
            incr n
         }
         if {$n == 31} {
            error "Cacheable segment size defined by $baseaddr = $cache_base and $highaddr = $cache_high must be a power-of-two." "" "mdt_error"
            set retval [expr $retval + 1]
         }

         if {($cache_base & ($power_of_two - 1)) != 0} {
            error "The $n least significant bits of $baseaddr are not zero, which must be the case when the cacheable segment size defined by $baseaddr = $cache_base and $highaddr = $cache_high is 2^$n." "" "mdt_error"
            set retval [expr $retval + 1]
         }
      }
   }

   return $retval
}

proc check_icache {mhsinst} {
   return [check_cache $mhsinst "C_ICACHE_BASEADDR" "C_ICACHE_HIGHADDR"]
}

proc check_dcache {mhsinst} {
   return [check_cache $mhsinst "C_DCACHE_BASEADDR" "C_DCACHE_HIGHADDR"]
}

proc check_iplevel_settings {mhsinst} {

   # To allow 2kB or 4kB cache sizes with Spartan 3 or 3E families
   # please change this variable to 1
   set IGNORE_DATA_CACHE_SIZE_ERROR 0

   set retval 0

   ####################################################################
   # Check caches
   ####################################################################
   set use_icache [xget_hw_parameter_value $mhsinst "C_USE_ICACHE"]
   set use_dcache [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]

   if {$use_icache == "1"} {
      set reti [check_icache $mhsinst]
      set retval [expr $retval + $reti]
   }

   if {$use_dcache == "1"} {
      set retd [check_dcache $mhsinst]
      set retval [expr $retval + $retd]
   }

   
   #########################################################################
   # Check parameter dependencies and issue warning for illegal combinations
   #########################################################################
   set use_div            [xget_hw_parameter_value $mhsinst "C_USE_DIV"]
   set div_zero_exception [xget_hw_parameter_value $mhsinst "C_DIV_ZERO_EXCEPTION"]
   if {$use_div == 0 && $div_zero_exception == 1} {
     warning $mhsinst "Divide By Zero Exception is enabled, but cannot occur since division is not enabled. Consider disabling the exception, to avoid unnecessary logic."
   }

   set use_fpu       [xget_hw_parameter_value $mhsinst "C_USE_FPU"]
   set fpu_exception [xget_hw_parameter_value $mhsinst "C_FPU_EXCEPTION"]
   if {$use_fpu == 0 && $fpu_exception == 1} {
     warning $mhsinst "FPU Exception is enabled, but cannot occur since the FPU is not enabled. Consider disabling the exception, to avoid unnecessary logic."
   }

   set area_optimized   [xget_hw_parameter_value $mhsinst "C_AREA_OPTIMIZED"]
   set family           [xget_hw_parameter_value $mhsinst "C_FAMILY"]
   set use_dcache       [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]
   set dcache_byte_size [xget_hw_parameter_value $mhsinst "C_DCACHE_BYTE_SIZE"]
   set use_writeback    [xget_hw_parameter_value $mhsinst "C_DCACHE_USE_WRITEBACK"]
   if {$family == "aspartan3" || $family == "aspartan3e" || $family == "spartan3"  || $family == "spartan3e"} {
     if {($area_optimized == 0 || $use_writeback == 1) && $use_dcache == 1} {
       if {$IGNORE_DATA_CACHE_SIZE_ERROR == 0} {
         if {$dcache_byte_size < 8192 && $dcache_byte_size > 1024} {
           error "Byte and halfword write instructions cannot be used with \"${family}\" when data cache size is set to 4kB or 2kB. Please select a different data cache size to correct this error. If it is necessary to use 2kB or 4kB data cache size, and only word write instructions are used, this error check can be disabled by setting IGNORE_DATA_CACHE_SIZE_ERROR to 1 in the MicroBlaze TCL file." "" "mdt_error"
           incr retval
         }
       } else {
         if {$dcache_byte_size < 4096 && $dcache_byte_size > 1024} {
           warning $mhsinst "Byte and halfword write instructions cannot be used with \"${family}\" when data cache size is set to 2kB."
         } elseif {$dcache_byte_size < 8192 && $dcache_byte_size > 1024} {
           warning $mhsinst "Byte write instructions cannot be used with \"${family}\" when data cache size is set to 4kB or 2kB."
         }
       }
     }
   }

   set fault_tolerant [xget_hw_parameter_value $mhsinst "C_FAULT_TOLERANT"]
   if {$fault_tolerant > 0 && $use_writeback == 1} {
     error "Write-back data cache is not available when fault tolerance is used, since error correction is currently not implemented. Please either use write-through data cache or disable fault tolerance to correct this error." "" "mdt_error"
     incr retval
   }

   return $retval
}

#***--------------------------------***-----------------------------------***
#
#			     SYSLEVEL_UPDATE_VALUE_PROC
#
#***--------------------------------***-----------------------------------***

proc update_icache_tag_bits {param_handle} {
   set msb_base 0
   set msb_high 0
   set mhsinst [xget_hw_parent_handle $param_handle]

   set use_icache [xget_hw_parameter_value $mhsinst "C_USE_ICACHE"]
   set icache_base [xformat_address_string [xget_hw_parameter_value $mhsinst "C_ICACHE_BASEADDR"]]
   set icache_high [xformat_address_string [xget_hw_parameter_value $mhsinst "C_ICACHE_HIGHADDR"]]
   set icache_size [xget_hw_parameter_value $mhsinst "C_CACHE_BYTE_SIZE"]

   if {$use_icache == "0"} {
      return 0;
   }

   # Is ICache valid
   set icache_valid [check_icache $mhsinst]
   if {$icache_valid != 0} {
      return 0;
   }

   # TCL does not do unsigned
   if {$icache_base < 0} {
      set msb_base 1
   }
   if {$icache_high < 0} {
      set msb_high 1
   }
   # Handle case of cacheing the entire address space
   if {($msb_high  == "1") && ($msb_base == "0")} {
      set icache_addrbits 32
   } else {
      set icache_addrsize [expr $icache_high - $icache_base + 1]
      set icache_addrbits [expr int(log($icache_addrsize) / log(2))]
   }
   set icache_bits [expr int(log($icache_size) / log(2))]

   # Byte and half-word enable bits cancel out
   set tag_bits [expr $icache_addrbits - $icache_bits]
   # puts "ICACHE tag bits: $tag_bits"

   return $tag_bits
}

proc update_dcache_tag_bits {param_handle} {
   set msb_base 0
   set msb_high 0
   set mhsinst [xget_hw_parent_handle $param_handle]
   set use_dcache [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]

   set dcache_base [xformat_address_string [xget_hw_parameter_value $mhsinst "C_DCACHE_BASEADDR"]]
   set dcache_high [xformat_address_string [xget_hw_parameter_value $mhsinst "C_DCACHE_HIGHADDR"]]
   set dcache_size [xget_hw_parameter_value $mhsinst "C_DCACHE_BYTE_SIZE"]

   if {$use_dcache == "0"} {
      return 0;
   }

   # Is DCache valid
   set dcache_valid [check_dcache $mhsinst]
   if {$dcache_valid != 0} {
     return 0;
   }

   # TCL does not do unsigned
   if {$dcache_base < 0} {
      set msb_base 1
   }
   if {$dcache_high < 0} {
      set msb_high 1
   }
   # Handle case of cacheing the entire address space
   if {($msb_high  == "1") && ($msb_base == "0")} {
      set dcache_addrbits 32
   } else {
      set dcache_addrsize [expr $dcache_high - $dcache_base + 1]
      set dcache_addrbits [expr int(log($dcache_addrsize) / log(2))]
   }
   set dcache_bits [expr int(log($dcache_size) / log(2))]

   # Byte and half-word enable bits cancel out
   set tag_bits [expr $dcache_addrbits - $dcache_bits]
   # puts "DCACHE tag bits: $tag_bits"

   return $tag_bits
}


#
# update parameter C_INTERRUPT_IS_EDGE 
#
proc syslevel_update_interrupt_edge { param_handle } {

    return [get_updated_interrupt_value $param_handle "C_INTERRUPT_IS_EDGE"]

}


#
# update parameter C_EDGE_IS_POSITIVE 
#
proc syslevel_update_edge_positive { param_handle } {

    return [get_updated_interrupt_value $param_handle "C_EDGE_IS_POSITIVE"]

}


proc get_updated_interrupt_value { param_handle param_return } {

    set mhsinst    [xget_hw_parent_handle  $param_handle]
    set mhs_handle [xget_hw_parent_handle  $mhsinst]

    # get the connector name which port "Interrupt" is connected to
    set connector  [xget_hw_port_value     $mhsinst      "Interrupt"]

    # if port "Interrupt" is not connected, or connected to a constant signal
    # return the existing value
    if {[llength $connector] == 0 || [string compare -nocase $connector "net_vcc"] == 0 || [string compare -nocase $connector "net_gnd"] == 0 || [string match -nocase 0b* $connector] || [string match -nocase 0x* $connector]} {

        return [xget_hw_parameter_value $mhsinst $param_return]
    }

    # get a list of ports connected to the connector
    # "Interrupt" is an IN port, so we use "source" port type
    set source_ports [xget_hw_connected_ports_handle $mhs_handle $connector "SOURCE"]

    foreach port $source_ports {

        set port_type    [xget_port_type $port]
   	set port_parent  [xget_hw_parent_handle $port]

	if {[string compare -nocase $port_type "local"] == 0 &&
	    ([string compare -nocase [xget_hw_value $port_parent] "xps_intc"] == 0 ||
	     [string compare -nocase [xget_hw_value $port_parent] "axi_intc"] == 0)} {

	    # The source is interrupt controller.
	    # will look at the parameters of C_IRQ_IS_LEVEL & C_IRQ_ACTIVE
	    # for xps_intc C_IRQ_IS_LEVEL may not exist: in this case IRQ is level

	    # get the parent handle of the port
	    set intc_handle [xget_hw_parent_handle   $port]
	    set intc_active [xget_hw_parameter_value $intc_handle "C_IRQ_ACTIVE"]

	    set intc_level_handle [xget_hw_parameter_handle $intc_handle "C_IRQ_IS_LEVEL"]
	    if {$intc_level_handle == ""} {

		# assume IRQ is level
		set intc_level 1

	    } else {

		set intc_level [xget_hw_parameter_value $intc_handle "C_IRQ_IS_LEVEL"]

	    }

     	    if { $intc_level == 0 && $intc_active == 1 } {

		# Rising Edge
 	        return 1

	    } elseif { $intc_level == 0 && $intc_active == 0 } {

		# Falling Edge
		if {[string compare -nocase $param_return "C_INTERRUPT_IS_EDGE"] == 0} {

		    return 1

		} else {

		    return 0

		}

	    } else {
	
		# High Level
		if {[string compare -nocase $param_return "C_INTERRUPT_IS_EDGE"] == 0} {

		    return 0

		} else {

		    # There is no LEVEL_LOW for level interrupts.
		    # will return existing value for parameter C_EDGE_IS_POSITIVE
		    return [xget_hw_parameter_value $mhsinst "C_EDGE_IS_POSITIVE"]

		}

	    }

    	} else {

	    # The source is an interrupt port from a peripheral or 
	    # a toplevel interrupt coming into MHS.
	    # will look at SENSITIVITY subproperty of the port
	    set senstivity_value [xget_hw_subproperty_value $port "SENSITIVITY"]

    	    # if the source port does not have SENSITIVITY subproperty
    	    # return the existing value
    	    if {[llength $senstivity_value] == 0} {

    	    	return [xget_hw_parameter_value $mhsinst $param_return]

	    }

	    if {[string match -nocase *EDGE* $senstivity_value] == 1 && [string match -nocase *RISING* $senstivity_value] == 1} {

		# SENSITIVITY=EDGE_RISING
	    	return 1

	    } elseif {[string match -nocase *EDGE* $senstivity_value] == 1 && [string match -nocase *FALLING* $senstivity_value] == 1} {

		# SENSITIVITY=EDGE_FALLING
		if {[string compare -nocase $param_return "C_INTERRUPT_IS_EDGE"] == 0} {

		    return 1

		} else {

		    return 0

		}

	    } else {

		# SENSITIVITY=LEVEL_HIGH
		if {[string compare -nocase $param_return "C_INTERRUPT_IS_EDGE"] == 0} {

		    return 0

		} else {

		    # There is no LEVEL_LOW for level interrupts.
		    # will return existing value for parameter C_EDGE_IS_POSITIVE
		    return [xget_hw_parameter_value $mhsinst "C_EDGE_IS_POSITIVE"]

		}

	    }

	}

    }

    return [xget_hw_parameter_value $mhsinst $param_return]

}


#
# update parameter C_D_AXI
#
proc syslevel_update_d_axi { param_handle } {
    return [is_param_connected $param_handle "M_AXI_DP_ARVALID"]
}


#
# update parameter C_D_PLB
#
proc syslevel_update_d_plb { param_handle } {
    return [is_param_connected $param_handle "DPLB_M_RNW"]
}


#
# update parameter C_D_LMB
#
proc syslevel_update_d_lmb { param_handle } {
    return [is_param_connected $param_handle "D_AS"]
}


#
# update parameter C_I_AXI
#
proc syslevel_update_i_axi { param_handle } {
    return [is_param_connected $param_handle "M_AXI_IP_ARVALID"]
}


#
# update parameter C_I_PLB
#
proc syslevel_update_i_plb { param_handle } {
    return [is_param_connected $param_handle "IPLB_M_RNW"]
}


#
# update parameter C_I_LMB
#
proc syslevel_update_i_lmb { param_handle } {
    return [is_param_connected $param_handle "I_AS"]
}

# Determine if bus is connected by finding sink of signal
proc is_param_connected { param_handle signal } {
    set mhsinst [xget_hw_parent_handle $param_handle]
    return [is_connected $mhsinst $signal]
}


#
# update parameter C_ICACHE_BASEADDR
# assume this is called before update_icache_highaddr and update_icache_tag_bits
#
proc update_icache_baseaddr {param_handle} {
    return [get_cache_addr $param_handle "BASE" "I"]
}

#
# update parameter C_ICACHE_HIGHADDR
# assume this is called after update_icache_baseaddr and before update_icache_tag_bits
#
proc update_icache_highaddr {param_handle} {
    return [get_cache_addr $param_handle "HIGH" "I"]
}

#
# update parameter C_DCACHE_BASEADDR
# assume this is called before update_dcache_highaddr and update_dcache_tag_bits
#
proc update_dcache_baseaddr {param_handle} {
    return [get_cache_addr $param_handle "BASE" "D"]
}

#
# update parameter C_DCACHE_HIGHADDR
# assume this is called after update_dcache_baseaddr and before update_dcache_tag_bits
#
proc update_dcache_highaddr {param_handle} {
    return [get_cache_addr $param_handle "HIGH" "D"]
}

# Determine cache address from connected IP
proc get_cache_addr { param_handle item side} {
    set mhsinst [xget_hw_parent_handle $param_handle]

    set use_cache [xget_hw_parameter_value $mhsinst "C_USE_${side}CACHE"]
    set cache_addr [xformat_address_string [xget_hw_parameter_value $mhsinst "C_${side}CACHE_${item}ADDR"]]

    # No change if cache disabled
    if {$use_cache == "0"} {
        return $cache_addr
    }

    # No change if either base or high address does not have default value when setting base address
    # No change if high address does not have default value when setting high address
    set cache_base [xformat_address_string [xget_hw_parameter_value $mhsinst "C_${side}CACHE_BASEADDR"]]
    set cache_high [xformat_address_string [xget_hw_parameter_value $mhsinst "C_${side}CACHE_HIGHADDR"]]

    if {($item == "BASE" && $cache_base != 0) || $cache_high != 0x3FFFFFFF} {
        return $cache_addr
    }

    # No change if no IP connected with the XCL bus
    set xcl_handle [xget_hw_busif_handle $mhsinst "${side}XCL"]
    if {$xcl_handle == ""} {
        return $cache_addr
    }

    set xcl_name [xget_hw_value $xcl_handle]
    if {$xcl_name == ""} {
        return $cache_addr
    }

    set xcl_busip_handle [xget_connected_p2p_busif_handle $xcl_handle ]
    if {$xcl_busip_handle == ""} {
        return $cache_addr
    }

    # No change if address list empty
    set ip_handle [xget_hw_parent_handle $xcl_busip_handle]
    set addrlist [xget_addr_values_list_for_ipinst $ip_handle]
    set addrlen [llength $addrlist]

    if {$addrlen == 0} {
        return $cache_addr
    }

    # Return address from first bank
    if {$item == "BASE"} {
        return [lindex $addrlist 0]
    } else {
        return [lindex $addrlist 1]
    }
}


#
# update parameter C_USE_INTERRUPT
#
proc syslevel_update_use_interrupt { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set mhs_handle [xget_hw_parent_handle $mhsinst]
  set signal_con [xget_hw_port_value $mhsinst "INTERRUPT"] 

  if {[llength $signal_con] > 0} {
    set signal_con_source [xget_connected_ports_handle $mhs_handle $signal_con "SOURCE"]
    
    if {[llength $signal_con_source] > 0} {
      return 1
    } else {
      return 0
    }
  } else {
    return 0
  }
}


#
# update parameter C_USE_EXT_BRK
#
proc syslevel_update_use_ext_brk { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set mhs_handle [xget_hw_parent_handle $mhsinst]
  set signal_con [xget_hw_port_value $mhsinst "EXT_BRK"] 

  if {[llength $signal_con] > 0} {
    set signal_con_source [xget_connected_ports_handle $mhs_handle $signal_con "SOURCE"]
    
    if {[llength $signal_con_source] > 0} {
      return 1
    } else {
      return 0
    }
  } else {
    return 0
  }
}


#
# update parameter C_USE_EXT_NM_BRK
#
proc syslevel_update_use_ext_nm_brk { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set mhs_handle [xget_hw_parent_handle $mhsinst]
  set signal_con [xget_hw_port_value $mhsinst "EXT_NM_BRK"] 

  if {[llength $signal_con] > 0} {
    set signal_con_source [xget_connected_ports_handle $mhs_handle $signal_con "SOURCE"]
    
    if {[llength $signal_con_source] > 0} {
      return 1
    } else {
      return 0
    }
  } else {
    return 0
  }
}


#***--------------------------------***-----------------------------------***
#
#			     IPLEVEL_UPDATE_VALUE_PROC
#
#***--------------------------------***-----------------------------------***

#
# update parameter C_ENDIANNESS
#
proc iplevel_update_endianness { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set interconnect [xget_hw_parameter_value $mhsinst "C_INTERCONNECT"]
  if {$interconnect == 2} {
    return 1
  } else {
    return 0
  }
}


#
# update parameter C_DCACHE_INTERFACE
#
proc iplevel_update_dcache_interface { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set use_writeback [xget_hw_parameter_value $mhsinst "C_DCACHE_USE_WRITEBACK"]
  if {$use_writeback} {
    return 1
  } else {
    return 0
  }
}


#
# update parameter C_xCACHE_USE_FSL
#
proc iplevel_update_cache_use_fsl {param_handle} {
   set mhs_handle [xget_hw_parent_handle   $param_handle]
   set inter_conn [xget_hw_parameter_value $mhs_handle "C_INTERCONNECT"]

   if { $inter_conn == 1 } {
      return 1
   } else {
      return 0
   }
}


#
# update parameter C_M_AXI_IC_READ_ISSUING
#
proc iplevel_update_m_axi_ic_read_issuing {param_handle} {
   set mhs_handle     [xget_hw_parent_handle   $param_handle]
   set inter_conn     [xget_hw_parameter_value $mhs_handle "C_INTERCONNECT"]
   set icache_streams [xget_hw_parameter_value $mhs_handle "C_ICACHE_STREAMS"]

   if { $inter_conn == 2 && $icache_streams == 1 } {
      return 8
   } else {
      return 2
   }
}


#
# update parameter C_M_AXI_IC_DATA_WIDTH
#
proc iplevel_update_m_axi_ic_data_width {param_handle} {
   set mhs_handle           [xget_hw_parent_handle   $param_handle]
   set area_opt             [xget_hw_parameter_value $mhs_handle "C_AREA_OPTIMIZED"]
   set inter_conn           [xget_hw_parameter_value $mhs_handle "C_INTERCONNECT"]
   set icache_line_len      [xget_hw_parameter_value $mhs_handle "C_ICACHE_LINE_LEN"]
   set icache_data_width    [xget_hw_parameter_value $mhs_handle "C_ICACHE_DATA_WIDTH"]

   if { $inter_conn == 2 && $icache_data_width == 1 && $area_opt == 0 } {
      return [expr 32 * $icache_line_len]
   } else {
      return 32
   }
}

#
# update parameter C_M_AXI_DC_DATA_WIDTH
#
proc iplevel_update_m_axi_dc_data_width {param_handle} {
   set mhs_handle           [xget_hw_parent_handle   $param_handle]
   set area_opt             [xget_hw_parameter_value $mhs_handle "C_AREA_OPTIMIZED"]
   set inter_conn           [xget_hw_parameter_value $mhs_handle "C_INTERCONNECT"]
   set dcache_line_len      [xget_hw_parameter_value $mhs_handle "C_DCACHE_LINE_LEN"]
   set dcache_data_width    [xget_hw_parameter_value $mhs_handle "C_DCACHE_DATA_WIDTH"]
   set dcache_use_writeback [xget_hw_parameter_value $mhs_handle "C_DCACHE_USE_WRITEBACK"]

   if { $inter_conn == 2 && $dcache_use_writeback == 1 && $dcache_data_width == 1 && $area_opt == 0 } {
      return [expr 32 * $dcache_line_len]
   } else {
      return 32
   }
}


#
# update parameter C_M_AXI_DP_PROTOCOL
#
proc iplevel_update_m_axi_dp_protocol {param_handle} {
   set mhs_handle                [xget_hw_parent_handle   $param_handle]
   set inter_conn                [xget_hw_parameter_value $mhs_handle "C_INTERCONNECT"]
   set m_axi_dp_exclusive_access [xget_hw_parameter_value $mhs_handle "C_M_AXI_DP_EXCLUSIVE_ACCESS"]

   if { $inter_conn == 2 && ($m_axi_dp_exclusive_access == 1) } {
      return "AXI4"
   } else {
      return "AXI4LITE"
   }
}


#***--------------------------------***-----------------------------------***
#
#			     CORE_LEVEL_CONSTRAINTS
#
#***--------------------------------***-----------------------------------***

proc generate_corelevel_ucf {mhsinst} {

   set  filePath [xget_ncf_dir $mhsinst]

   file mkdir    $filePath

   # specify file name
   set    instname   [xget_hw_parameter_value $mhsinst "INSTANCE"]
   set    name_lower [string 	  tolower    $instname]
   set    fileName   $name_lower
   append fileName   "_wrapper.ucf"
   append filePath   $fileName

   # Open a file for writing
   set outputFile [open $filePath "w"]

   # Add TIG constraints for Reset, Mb_Reset and Interrupt when AXI is used
   set interconnect  [xget_hw_parameter_value $mhsinst "C_INTERCONNECT"]
   set use_interrupt [xget_hw_parameter_value $mhsinst "C_USE_INTERRUPT"]

   if {$interconnect == 2} {
     puts "INFO: Setting timing constaints for ${instname}."

     #puts $outputFile "INST \"${name_lower}/Reset_DFF.reset_temp\" TNM = \"${name_lower}_Reset_dst\"; "
     #puts $outputFile "TIMESPEC \"TS_TIG_${name_lower}_Reset\" = FROM FFS TO \"${name_lower}_Reset_dst\" TIG; "

     if {$use_interrupt != 0} {
        #puts $outputFile "INST \"${name_lower}/external_interrupt\" TNM = \"${name_lower}_Interrupt_dst\"; "
        #puts $outputFile "TIMESPEC \"TS_TIG_${name_lower}_Interrupt\" = FROM FFS TO \"${name_lower}_Interrupt_dst\" TIG; "
     }
   }

   # Close the file
   close  $outputFile

   puts   [xget_ncf_loc_info $mhsinst]
}


#***--------------------------------***------------------------------------***
#
#                   GUI PROC (MicroBlaze Configuration Wizard)
#
#***--------------------------------***------------------------------------***

# Template Data loaded from XML
# Each template-item consists of: name, tooltip, icon, info-list
# An info-list consists of: parameter, value
set ::config_template_data {}

# Area data for all supported families loaded from XML
# Each area-data-item consists of: family-list reference-list parameters-list
# A parameters-list item consists of: parameter-list expressions-list
# An expressions-list item consists of: conditional-expression value-expression
set ::config_area_data {}

# Frequency data for all supported families loaded from XML
# Each frequency-data-item consists of: family-list reference-list parameters-list
# A parameters-list item consists of: parameter-list expressions-list
# An expressions-list item consists of: conditional-expression value-expression
set ::config_frequency_data {}

# Performance data for all parameters loaded from XML
# The only performance-data-item consists of: family-list reference-list parameters-list
# A parameters-list item consists of: parameter-list expressions-list
# An expressions-list item consists of: conditional-expression value-expression
set ::config_performance_data {}

# Previous selected wizard page
set ::gui_prev_wizard_page 0

# Information about defined buses
set ::icache_bus 1
set ::dcache_bus 1
set ::debug_bus 1

# XML read:
#   xload_xilinx_library libmXMLTclIf
#   puts "Reading input.xml.."
#   set ele [xxml_read_file "input.xml"]
#   puts "Writing to output.xml.."
#   xxml_write_file $ele "output.xml"
#   puts "Creating new root element..."
#   set newele [xxml_create_root_element "myroot"]
#   set addedele [xxml_add_element $newele "child1"]
#   set addedele2 [xxml_add_element $newele "child2"]
#   set parent [xxml_get_parent $addedele]
#   puts "orig_parent: $newele, returned parent: $parent"
#   xxml_add_property $addedele "prop1" "val1"
#   xxml_add_property $addedele "prop2" "val2"
#   set returned_propval [xxml_find_property $addedele "prop1"]
#   puts "inprop_val: val1, outprop_val: $returned_propval"
#   xxml_write_file $newele "myroot.xml"
#   set numsubele [llength [xxml_get_sub_elements $newele]]
#   puts "$numsubele sub elements found"
#   xxml_del_property $addedele "prop1"
#   xxml_write_file $newele "myroot2.xml"
#   puts "Cleaningup the XML object.."
#   xxml_cleanup $newele
#
#   xxml_get_sub_elements $xmlDescFPGA "ParameterName\[@name=$param\]"
#
#   xxml_get_text $xmlData
#   xxml_set_text $xmlData $value

proc config_read_templates {templates_ele} {
  set templates [xxml_get_sub_elements $templates_ele]
  set template_data {}
  foreach template $templates {
    set template_item {}
    set item_ele    [xxml_get_sub_elements $template]
    set name        [xxml_get_text [lindex $item_ele 0]]
    set tooltip     [xxml_get_text [lindex $item_ele 1]]
    set icon        [xxml_get_text [lindex $item_ele 2]]
    # puts "DEBUG: name=\"$name\", tooltip=\"$tooltip\", icon=\"$icon\""
    set info_item {}
    for {set i 3} {$i < [llength $item_ele]} {incr i} {
      set info_ele  [xxml_get_sub_elements [lindex $item_ele $i]]
      set parameter [xxml_get_text [lindex $info_ele 0]]
      set value     [xxml_get_text [lindex $info_ele 1]]
      # puts "DEBUG: parameter=\"$parameter\", value=\"$value\""
      lappend info_item [list $parameter $value]
    }
    lappend template_item [list $name $tooltip $icon]
    lappend template_item $info_item
    lappend template_data $template_item
  }
  return $template_data
}

proc config_read_data_items {dataitem_ele {current_family ""}} {
  # puts "DEBUG: config_read_data_items ---------------------"
  set item_data {}
  set itemdata [xxml_get_sub_elements $dataitem_ele]
  foreach dataitem $itemdata {
    set datasource_ele  [xxml_get_sub_elements $dataitem "datasource"]
    set families_ele    [xxml_get_sub_elements $dataitem "families"]
    set limits_ele      [xxml_get_sub_elements $dataitem "limits"]
    set calculation_ele [xxml_get_sub_elements $dataitem "calculation"]

    set datasources {}
    set datasource_items [xxml_get_sub_elements $datasource_ele]
    foreach datasource $datasource_items {
      set datasource_item [xxml_get_text $datasource]
      lappend datasources $datasource_item
      # puts "DEBUG: datasource=\"$datasource_item\""
    }

    set families {}
    if {[llength $families_ele] > 0} {
      set families_items [xxml_get_sub_elements $families_ele]
      foreach family $families_items {
        set family_item [xxml_get_text $family]
        lappend families $family_item
        # puts "DEBUG: family=\"$family_item\""
      }
    }

    set limits {}
    set limits_items [xxml_get_sub_elements $limits_ele]
    foreach limit $limits_items {
      set limit_item [xxml_get_text $limit]
      lappend limits $limit_item
      # puts "DEBUG: limit=\"$limit_item\""
    }

    set calculations {}
    foreach calculation $calculation_ele {
      set parameter_ele [xxml_get_sub_elements $calculation "parameter"]
      set parameters  {}
      foreach item $parameter_ele {
        set parameter [xxml_get_text $item]
        lappend parameters $parameter
        # puts "DEBUG: parameter=\"$parameter\""
      }

      set expressions_ele [xxml_get_sub_elements $calculation "expression"]
      set expressions {}
      foreach item $expressions_ele {
        set expression_ele [xxml_get_sub_elements $item]
        set condition [xxml_get_text [lindex $expression_ele 0]]
        set value     [xxml_get_text [lindex $expression_ele 1]]
        lappend expressions [list $condition $value]
        # puts "DEBUG: condition=\"$condition\", value=\"$value\""
      }

      lappend calculations [list $parameters $expressions]
    }
    # Only add data for current family
    if {$current_family == "" || [lsearch -exact $families $current_family] != -1} {
      lappend item_data [list $families $datasources $limits $calculations]
    }
  }
  return $item_data
}

proc config_read_data {mhsinst family} {
  xload_xilinx_library libmXMLTclIf

  set pcore_data_dir [xget_hw_pcore_dir $mhsinst]
  set pcore_cw_data_file [file join $pcore_data_dir "microblaze_cw_data_xps.xml"]
  # puts "DEBUG: $pcore_data_dir $pcore_cw_data_file"

  set cw_data [xxml_read_file $pcore_cw_data_file]
  set sub_ele [xxml_get_sub_elements $cw_data]

  # DEBUG:
  # xxml_write_file $cw_data "output.xml"
  # puts "DEBUG: numsubele = [llength $sub_ele]"

  # Extract template data from XML
  set ::config_template_data [config_read_templates [lindex $sub_ele 1]]

  # Extract data items from XML for area, frequency and performance
  set ::config_area_data        [config_read_data_items [lindex $sub_ele 2] $family]
  set ::config_frequency_data   [config_read_data_items [lindex $sub_ele 3] $family]
  set ::config_performance_data [config_read_data_items [lindex $sub_ele 4]]

  xxml_cleanup $cw_data
}

# Check if a family is included in a family list
proc config_find {family familylist} {
  foreach item $familylist {
    if {[regexp -nocase "^${item}\$" $family]} { return 1 }
  }
  return 0
}

# Determine the number of BRAMs for a family, given data width, address width and if BRAM is forced
# This algorithm corresponds to the VHDL code in "ram_module.vhd"
proc config_ram_module_brams {family data_width addr_width force_bram force_lutram use_parity} {
  set family_virtex4        [config_find $family {virtex4 qvirtex4 qrvirtex4}]
  set arch_36kbit_bram      [config_find $family {virtex5 virtex6}]
  set arch_16kbit_we_bram   [config_find $family {spartan3a spartan3an spartan3adsp aspartan3adsp spartan6}]
  set byte_enable_bram_arch [config_find $family \
    {virtex5 virtex4 qvirtex4 qrvirtex4 spartan3a spartan3an spartan3adsp aspartan3adsp virtex6 spartan6}]

  # 00: !force_bram && !arch_36kbit_bram
  # 01: !force_bram &&  arch_36kbit_bram
  # 10:  force_bram && !arch_36kbit_bram
  # 11:  force_bram &&  arch_36kbit_bram
  set ram_select_lookup {
    {0  1  2  3  4  5  6  7  8  9 10 11 12 13 14}
    {0  1  2  3  4  5  6  7  8 15 16 17 18 19 20}
    {0  9  9  9  9  9  9  9  9  9 10 11 12 13 14}
    {0 15 15 15 15 15 15 15 15 15 16 17 18 19 20}}

  set bram_type_lookup {
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"B16_S36" 36}
    {"B16_S18" 18}
    {"B16_S9"   9}
    {"B16_S4"   4}
    {"B16_S2"   2}
    {"B16_S1"   1}
    {"B36_S36" 36}
    {"B36_S36" 36}
    {"B36_S18" 18}
    {"B36_S9"   9}
    {"B36_S4"   4}
    {"B36_S2"   2}
    {"B36_S1"   1}}

  set ram_select [lindex $ram_select_lookup [expr $force_bram * 2 + $arch_36kbit_bram]]
  set what_bram  [lindex $bram_type_lookup [lindex $ram_select $addr_width]]
  set bram_type  [lindex $what_bram 0]
  set bram_full_data_width [lindex $what_bram 1]

  set extra_parity_brams 0
  if {$bram_full_data_width == 2 || $bram_full_data_width == 4} {
    set extra_parity_brams [expr (4 - 4 / $bram_full_data_width) * $use_parity]
  }

  set nr_of_brams [expr ($data_width + $bram_full_data_width - 1) / $bram_full_data_width + $extra_parity_brams]
  # puts "DEBUG: ram select = $ram_select $what_bram $bram_type $bram_full_data_width $nr_of_brams"

  if {$bram_type == "DISTRAM" || $force_lutram} { return 0 }

  if {$bram_type == "B16_S36" || $bram_type == "B36_S36"} {
    if {$arch_36kbit_bram || $family_virtex4 || $arch_16kbit_we_bram} { return 1 }
  }

  return $nr_of_brams
}

# Calculate the number of BRAMs in a system. Depends on the following parameters:
#  C_FAMILY C_AREA_OPTIMIZED C_USE_ICACHE C_USE_DCACHE C_USE_MMU
#  C_CACHE_BYTE_SIZE C_ICACHE_LINE_LEN C_ICACHE_BASEADDR C_ICACHE_HIGHADDR
#  C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN C_DCACHE_BASEADDR C_DCACHE_HIGHADDR
#  C_DCACHE_USE_WRITEBACK C_USE_BRANCH_TARGET_CACHE C_BRANCH_TARGET_CACHE_SIZE
proc config_calculate_brams {mhsinst} {
   set total_brams 0

   set area_optimized [xget_hw_parameter_value $mhsinst "C_AREA_OPTIMIZED"]
   set family         [xget_hw_parameter_value $mhsinst "C_FAMILY"]
   set use_icache     [xget_hw_parameter_value $mhsinst "C_USE_ICACHE"]
   set use_dcache     [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]
   set use_mmu        [xget_hw_parameter_value $mhsinst "C_USE_MMU"]
   set use_btc        [xget_hw_parameter_value $mhsinst "C_USE_BRANCH_TARGET_CACHE"]
   set use_parity     [expr [xget_hw_parameter_value $mhsinst "C_FAULT_TOLERANT"] > 0]

   # icache
   if {$use_icache} {
     set cache_byte_size [xget_hw_parameter_value $mhsinst "C_CACHE_BYTE_SIZE"]
     set icache_line_len [xget_hw_parameter_value $mhsinst "C_ICACHE_LINE_LEN"]
     set addr_tag_bits   [xget_hw_parameter_value $mhsinst "C_ADDR_TAG_BITS"]

     if {$use_mmu == 3 && $area_optimized == 0} {
       set addr_tag_bits [expr 32 - int(log($cache_byte_size) / log(2)) + 9] ; # C_MMU_BITS = 9
       if {$addr_tag_bits <= 0} { set addr_tag_bits 1 }
     }

     set tag_word_size   [expr $icache_line_len + 1 + $addr_tag_bits + $use_parity]
     set nr_of_tag_words [expr $cache_byte_size / ($icache_line_len * 4)]
     set tag_addr_size   [expr int(log($nr_of_tag_words) / log(2))]
     set data_word_size  [expr 32 + $use_parity]
     set data_addr_size  [expr int(log($cache_byte_size / 4) / log(2))]
     set force_lutram    [xget_hw_parameter_value $mhsinst "C_ICACHE_FORCE_TAG_LUTRAM"]
     set force_bram      [expr $data_addr_size >= 9 && ! $force_lutram]

     # puts "DEBUG: data_addr_size = $data_addr_size $cache_byte_size $force_bram"

     set icache_tag_brams  [config_ram_module_brams $family $tag_word_size $tag_addr_size $force_bram $force_lutram 0]
     set icache_data_brams [config_ram_module_brams $family $data_word_size $data_addr_size 0 0 0]

     # puts "DEBUG: icache_tag_brams = \"${icache_tag_brams}\", icache_data_brams = \"$icache_data_brams\""
     set total_brams [expr $total_brams + $icache_tag_brams + $icache_data_brams]
   }

   # dcache
   if {$use_dcache} {
     set dcache_byte_size     [xget_hw_parameter_value $mhsinst "C_DCACHE_BYTE_SIZE"]
     set dcache_line_len      [xget_hw_parameter_value $mhsinst "C_DCACHE_LINE_LEN"]
     set dcache_addr_tag      [xget_hw_parameter_value $mhsinst "C_DCACHE_ADDR_TAG"]
     set dcache_use_writeback [xget_hw_parameter_value $mhsinst "C_DCACHE_USE_WRITEBACK"]

     set tag_word_size   [expr $dcache_line_len + 1 + $dcache_addr_tag + $dcache_use_writeback + $use_parity]
     set nr_of_tag_words [expr $dcache_byte_size / ($dcache_line_len * 4)]
     set tag_addr_size   [expr int(log($nr_of_tag_words) / log(2))]
     set data_word_size  [expr 32 + 4 * $use_parity]
     set data_addr_size  [expr int(log($dcache_byte_size / 4) / log(2))]
     set force_lutram    [xget_hw_parameter_value $mhsinst "C_DCACHE_FORCE_TAG_LUTRAM"]
     set force_bram      [expr $data_addr_size >= 9 && ! $force_lutram]
     set data_force_bram [expr $area_optimized == 1 && $dcache_use_writeback == 0]

     set dcache_tag_brams  [config_ram_module_brams $family $tag_word_size $tag_addr_size $force_bram $force_lutram 0]
     set dcache_data_brams [config_ram_module_brams $family $data_word_size $data_addr_size $data_force_bram 0 $use_parity]

     # puts "DEBUG: dcache_tag_brams = \"${dcache_tag_brams}\", dcache_data_brams = \"$dcache_data_brams\""
     set total_brams [expr $total_brams + $dcache_tag_brams + $dcache_data_brams]
   }

   # mmu
   if {$use_mmu >= 2 && $area_optimized == 0} { incr total_brams }

   # btc
   if {$use_btc && $area_optimized == 0} {
     set btc_size [xget_hw_parameter_value $mhsinst "C_BRANCH_TARGET_CACHE_SIZE"]
     if {$btc_size == 0} { incr total_brams 1 }
     if {$btc_size == 5} { incr total_brams 2 }
     if {$btc_size == 6} { incr total_brams 3 }
     if {$btc_size == 7} { incr total_brams 7 }
   }

   # puts "DEBUG: total_brams = \"${total_brams}\""
   return $total_brams
}

# Determine the label index for DSP48 or MULT18 in a system.
# Depends on the following parameters:
#  C_FAMILY
proc config_label_index_dsp48_mult18 {mhsinst} {
   set family     [xget_hw_parameter_value $mhsinst "C_FAMILY"]

   set use_dsp48e  [config_find $family {virtex5}]
   set use_dsp48   [config_find $family {virtex4 qvirtex4 qrvirtex4}]
   set use_dsp48a  [config_find $family {spartan3adsp aspartan3adsp}]
   set use_dsp48a1 [config_find $family {spartan6}]
   set use_dsp48e1 [config_find $family {virtex6}]

   if {$use_dsp48e}  { return 0 }
   if {$use_dsp48}   { return 1 }
   if {$use_dsp48a}  { return 2 }
   if {$use_dsp48a1} { return 3 }
   if {$use_dsp48e1} { return 4 }
   return 5
}

# Calculate the number of DSP48 or MULT18 in a system. Depends on the following parameters:
#  C_FAMILY, C_USE_HW_MUL, C_USE_FPU
proc config_calculate_dsp48_mult18 {mhsinst} {
   set total 0

   set family     [xget_hw_parameter_value $mhsinst "C_FAMILY"]
   set use_hw_mul [xget_hw_parameter_value $mhsinst "C_USE_HW_MUL"]
   set use_fpu    [xget_hw_parameter_value $mhsinst "C_USE_FPU"]

   set use_dsp48e [config_find $family {virtex5 virtex6}]
   set use_dsp48  [config_find $family {virtex4 qvirtex4 qrvirtex4}]
   set use_dsp48a [config_find $family {spartan3adsp aspartan3adsp spartan6}]
   set use_mult18 [expr $use_dsp48e == 0 && $use_dsp48 == 0 && $use_dsp48a == 0]

   # Integer multiply
   if {$use_hw_mul > 0} {
     if {$use_dsp48e} { incr total 3 }
     if {$use_dsp48}  { incr total 3 }
     if {$use_dsp48a} { incr total 3 }
     if {$use_mult18} { incr total 3 }
   }

   if {$use_hw_mul == 2} {
     if {$use_dsp48e} { incr total 1 }
     if {$use_dsp48}  { incr total 1 }
     if {$use_dsp48a} { incr total 2 }
     if {$use_mult18} { incr total 1 }
   }

   # Float multiply
   if {$use_fpu > 0} {
     if {$use_dsp48e} { incr total 2 }
     if {$use_dsp48}  { incr total 4 }
     if {$use_dsp48a} { incr total 5 }
     if {$use_mult18} { incr total 4 }
   }

   return $total
}

# Evaluate a parameter expression string
proc config_evalexpr {mhsinst expr} {
  set expritemlist [split $expr]
  set evallist {}
  foreach expritem $expritemlist {
    if {[string first "C_" $expritem] == 0} {
      set value [xget_hw_parameter_value $mhsinst $expritem]
      if {$value != ""} {
        lappend evallist $value
      } else {
        lappend evallist 0 ; # error: return zero
      }
    } else {
      if {$expritem != ""} {
        lappend evallist $expritem
      }
    }
  }
  return [expr [join $evallist]]
}

# Calculate percentage
proc config_calculate_percentage {numerator denominator} {
  set percentage 0
  if {$denominator > 0} {
    set percentage [expr round($numerator * 100 / $denominator)]
    if {$percentage > 100} { set percentage 100 }
    if {$percentage <   0} { set percentage   0 }
  }
  return $percentage
}

# Calculate the expected area in a system. Depends on the following parameters:
#  C_FAMILY C_AREA_OPTIMIZED C_INTERCONNECT C_DPLB_DWIDTH C_DPLB_P2P
#  C_IPLB_DWIDTH C_IPLB_P2P C_D_PLB C_D_AXI C_D_LMB C_I_PLB
#  C_I_AXI C_I_LMB C_USE_MSR_INSTR C_USE_PCMP_INSTR C_USE_BARREL
#  C_USE_DIV C_USE_HW_MUL C_USE_FPU C_UNALIGNED_EXCEPTIONS
#  C_ILL_OPCODE_EXCEPTION C_M_AXI_I_BUS_EXCEPTION C_M_AXI_D_BUS_EXCEPTION
#  C_IPLB_BUS_EXCEPTION C_DPLB_BUS_EXCEPTION C_DIV_ZERO_EXCEPTION
#  C_FPU_EXCEPTION C_FSL_EXCEPTION C_PVR C_DEBUG_ENABLED
#  C_NUMBER_OF_PC_BRK C_NUMBER_OF_RD_ADDR_BRK C_NUMBER_OF_WR_ADDR_BRK
#  C_OPCODE_0x0_ILLEGAL C_FSL_LINKS C_USE_EXTENDED_FSL_INSTR
#  C_USE_ICACHE C_CACHE_BYTE_SIZE C_ICACHE_LINE_LEN C_ICACHE_ALWAYS_USED
#  C_ICACHE_INTERFACE C_ICACHE_STREAMS C_ICACHE_VICTIMS C_USE_DCACHE
#  C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN C_DCACHE_ALWAYS_USED
#  C_DCACHE_INTERFACE C_DCACHE_USE_WRITEBACK C_DCACHE_VICTIMS
#  C_USE_MMU C_MMU_DTLB_SIZE C_MMU_ITLB_SIZE C_MMU_TLB_ACCESS
#  C_MMU_ZONES C_USE_INTERRUPT C_USE_EXT_BRK C_USE_EXT_NM_BRK
#  C_USE_BRANCH_TARGET_CACHE C_BRANCH_TARGET_CACHE_SIZE
proc config_calculate_area {mhsinst} {
  set total_area 0
  set family [xget_hw_parameter_value $mhsinst "C_FAMILY"]

  set limits {0}
  foreach dataitem $::config_area_data {
    set familylist [lindex $dataitem 0]
    if {[lsearch -exact $familylist $family] != -1} {
      # puts "DEBUG: found family $family"
      set limits [lindex $dataitem 2]
      set paramlist [lindex $dataitem 3]
      foreach paramitem $paramlist {
        set exprlist [lindex $paramitem 1]
        foreach expritem $exprlist {
          set boolexpr [lindex $expritem 0]
          # puts "DEBUG: boolean expression: \"$boolexpr\""
          if {[config_evalexpr $mhsinst $boolexpr]} {
            set valueexpr [lindex $expritem 1]
            incr total_area [config_evalexpr $mhsinst $valueexpr]
          }
        }
      }
      break
    }
  }

  set maximum_area [lindex $limits end]

  set percentage [config_calculate_percentage $total_area $maximum_area]
  # puts "DEBUG: total area: $total_area ($percentage %)"

  return $percentage
}

# Calculate the expected frequency in a system. Depends on the following
# parameters:
#  C_FAMILY C_AREA_OPTIMIZED C_INTERCONNECT
#  C_D_PLB C_D_AXI C_D_LMB C_I_PLB C_I_AXI C_I_LMB
#  C_USE_MSR_INSTR C_USE_PCMP_INSTR C_USE_BARREL
#  C_USE_DIV C_USE_HW_MUL C_USE_FPU C_UNALIGNED_EXCEPTIONS
#  C_ILL_OPCODE_EXCEPTION C_M_AXI_I_BUS_EXCEPTION
#  C_M_AXI_D_BUS_EXCEPTION C_IPLB_BUS_EXCEPTION
#  C_DPLB_BUS_EXCEPTION C_DIV_ZERO_EXCEPTION
#  C_FPU_EXCEPTION C_FSL_EXCEPTION C_PVR
#  C_DEBUG_ENABLED C_NUMBER_OF_PC_BRK C_NUMBER_OF_RD_ADDR_BRK
#  C_NUMBER_OF_WR_ADDR_BRK C_OPCODE_0x0_ILLEGAL C_FSL_LINKS
#  C_USE_EXTENDED_FSL_INSTR C_USE_ICACHE C_CACHE_BYTE_SIZE
#  C_ICACHE_LINE_LEN C_ICACHE_ALWAYS_USED C_ICACHE_INTERFACE 
#  C_ICACHE_STREAMS C_ICACHE_VICTIMS C_USE_DCACHE
#  C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN C_DCACHE_ALWAYS_USED
#  C_DCACHE_INTERFACE C_DCACHE_USE_WRITEBACK C_DCACHE_VICTIMS
#  C_USE_MMU C_MMU_DTLB_SIZE C_MMU_ITLB_SIZE C_MMU_TLB_ACCESS
#  C_MMU_ZONES C_USE_INTERRUPT C_USE_EXT_BRK C_USE_EXT_NM_BRK
#  C_USE_BRANCH_TARGET_CACHE C_BRANCH_TARGET_CACHE_SIZE
# Frequency also depends on speed grade, but the percentage can be considered 
# independent of the speed grade.
proc config_calculate_frequency {mhsinst} {
  # DEBUG: return [expr int(rand() * 100.0)]
  set best_fit 0
  set best_fit_freq 0
  set family [xget_hw_parameter_value $mhsinst "C_FAMILY"]

  set limits {0}
  foreach dataitem $::config_frequency_data {
    set familylist [lindex $dataitem 0]
    if {[lsearch -exact $familylist $family] != -1} {
      # puts "DEBUG: found family $family"
      set limits [lindex $dataitem 2]
      set paramlist [lindex $dataitem 3]
      foreach paramitem $paramlist {
        set exprlist [lindex $paramitem 1]
        foreach expritem $exprlist {
          set fit_expr [lindex $expritem 0]
          # puts "DEBUG: fit expression: \"$fit_expr\""
          if {$fit_expr != ""} {
            set current_fit [config_evalexpr $mhsinst $fit_expr]
          } else {
            set current_fit 0
          }
          if {$current_fit > $best_fit} {
            set best_fit $current_fit
            set best_fit_freq [lindex $expritem 1]
          }
          # puts "DEBUG: current: \"$current_fit\", best: \"$best_fit\", best freq: \"$best_fit_freq\""
        }
      }
      break
    }
  }

  set maximum_freq [lindex $limits end]

  set percentage [config_calculate_percentage $best_fit_freq $maximum_freq]
  # puts "DEBUG: best fit freq: $best_fit_freq ($percentage %), max freq: $maximum_freq"

  return $percentage
}

# Calculate the expected performance in a system. Depends on the following parameters:
#  C_AREA_OPTIMIZED C_USE_MSR_INSTR C_USE_PCMP_INSTR C_USE_BARREL
#  C_USE_DIV C_USE_HW_MUL C_USE_FPU C_USE_ICACHE C_CACHE_BYTE_SIZE
#  C_ICACHE_LINE_LEN C_ICACHE_STREAMS C_ICACHE_VICTIMS C_USE_DCACHE
#  C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN  C_DCACHE_USE_WRITEBACK
#  C_DCACHE_VICTIMS C_USE_MMU C_MMU_DTLB_SIZE C_MMU_ITLB_SIZE
#  C_USE_BRANCH_TARGET_CACHE C_BRANCH_TARGET_CACHE_SIZE
proc config_calculate_performance {mhsinst} {
  set total_perf 0.0

  set dataitem [lindex $::config_performance_data 0]
  set limits [lindex $dataitem 2]
  set paramlist [lindex $dataitem 3]
  foreach paramitem $paramlist {
    set exprlist [lindex $paramitem 1]
    foreach expritem $exprlist {
      set boolexpr [lindex $expritem 0]
      # puts "DEBUG: boolean expression: \"$boolexpr\""
      if {[config_evalexpr $mhsinst $boolexpr]} {
        set valueexpr [lindex $expritem 1]
        set value [config_evalexpr $mhsinst $valueexpr]
        if {$value != 0.0} {
          set total_perf [expr $total_perf + $value - 1.0]
        }
      }
    }
  }
  set total_perf   [expr 1.0 + $total_perf]

  set minimum_perf [lindex $limits 0]
  set maximum_perf [lindex $limits end]
  set numerator    [expr pow(2.0, $minimum_perf - $total_perf)]
  set denominator  [expr pow(2.0, $minimum_perf - $maximum_perf)]

  set percentage [config_calculate_percentage  [expr 0.1 * $denominator + 0.9 * $numerator] $denominator]
  # puts "DEBUG: total performance: $total_perf ($percentage %)"

  return $percentage
}

# Set a GUI item to a value
proc gui_set_item {mhsinst item {value "1"}} {
  set item_handle [xget_hw_parameter_handle $mhsinst $item]
  xset_hw_parameter_value $item_handle $value
}

# Change BRAM information shown in the configuration dialog
proc gui_set_bram_size {mhsinst} {
  set bram_size [config_calculate_brams $mhsinst]
  gui_set_item $mhsinst "G_SET_BRAM_SIZE" $bram_size
  # puts "DEBUG: total_brams = \"${bram_size}\""
}

# Change dsp48 or mult18 information shown in the configuration dialog
proc gui_set_dsp48_mult18_size {mhsinst} {
  set dsp48_mult18_size [config_calculate_dsp48_mult18 $mhsinst]
  gui_set_item $mhsinst "G_SET_DSP48_MULT18_SIZE" $dsp48_mult18_size

  set label_index [config_label_index_dsp48_mult18 $mhsinst]
  gui_set_item $mhsinst "G_SET_DSP48_MULT18_LABEL" $label_index
  # puts "DEBUG: total_dsp48=$dsp48_mult18_size, label_index=$label_index"
}

# Change frequency information shown in the configuration dialog
proc gui_set_frequency {mhsinst} {
  set frequency_value [config_calculate_frequency $mhsinst]
  gui_set_item $mhsinst "G_SET_FREQUENCY_VALUE" $frequency_value
  # puts "DEBUG: frequency = \"${frequency_value}\""
}

# Change area information shown in the configuration dialog
proc gui_set_area {mhsinst} {
  set area_value [config_calculate_area $mhsinst]
  gui_set_item $mhsinst "G_SET_AREA_VALUE" $area_value
  # puts "DEBUG: area = \"${area_value}\""
}

# Change performance information shown in the configuration dialog
proc gui_set_performance {mhsinst} {
  set performance_value [config_calculate_performance $mhsinst]
  gui_set_item $mhsinst "G_SET_PERFORMANCE_VALUE" $performance_value
  # puts "DEBUG: performance = \"${performance_value}\""
}

# Initialize the template indicated by current_row with current values
proc gui_init_template {mhsinst current_row} {
  if {$current_row < 0 || $current_row >= [llength $::config_template_data]} {
    return
  }

  set template_item [lindex [lindex $::config_template_data $current_row] 1]
  set new_template_item {}
  foreach item $template_item {
    set name  [lindex $item 0]
    set value [xget_hw_parameter_value $mhsinst $name]
    lappend new_template_item [list $name $value]
  }
  lset ::config_template_data [list $current_row 1] $new_template_item
  # puts -nonewline "DEBUG: new template item = \"${new_template_item}\""
}

# Change parameters, due to selection of a new template by the user, indicated by current_row
proc gui_set_template {mhsinst current_row} {
  set template_item [lindex [lindex $::config_template_data $current_row] 1]
  foreach item $template_item {
    set name   [lindex $item 0]
    set value  [lindex $item 1]
    set handle [xget_hw_parameter_handle $mhsinst $name]
    xset_hw_parameter_value $handle $value
  }
}

# Determine if a bus is defined
proc bus_is_defined { mhsinst bus } {
   set bus_handle [xget_hw_busif_handle $mhsinst $bus]
   if {$bus_handle == ""} {
     return 0
   }
   set bus_name [xget_hw_value $bus_handle]
   if {$bus_name == ""} {
     return 0
   }
   return 1
}

# Adjust template debug setting:
# Keep enabled if DEBUG bus connected, but warn if template wants to turn it off
proc gui_check_warn_debug {mhsinst} {
  set debug_enabled [xget_hw_parameter_value $mhsinst "C_DEBUG_ENABLED"]
  if {$debug_enabled == 0 && $::debug_bus != 0} {
    set handle [xget_hw_parameter_handle $mhsinst "C_DEBUG_ENABLED"]
    xset_hw_parameter_value $handle "1"
    puts " WARNING:EDK - Debug kept enabled, debug bus connected. If manually disabled, MDM must be removed from the system."
  }
}

# Change information shown in the configuration dialog, due to a user change
proc gui_set {mhsinst description} {
  gui_set_bram_size $mhsinst
  gui_set_dsp48_mult18_size $mhsinst
  gui_set_frequency $mhsinst
  gui_set_area $mhsinst
  gui_set_performance $mhsinst
  # puts "DEBUG: gui_set $description"
}

# Change page shown in the wizard
proc gui_set_wizard_page {mhsinst page} {
  gui_set_item $mhsinst "G_SET_STACKED_WIDGET_PAGE" [expr $page - 1]
  if {$page < 8} {
    set area_optimized [xget_hw_parameter_value $mhsinst "C_AREA_OPTIMIZED"]
    set mmu_enabled    [xget_hw_parameter_value $mhsinst "G_GET_MMU_ENABLED"]
    set use_icache     [xget_hw_parameter_value $mhsinst "C_USE_ICACHE"]
    set use_dcache     [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]
    set debug          [xget_hw_parameter_value $mhsinst "C_DEBUG_ENABLED"]
    set use_exc        [xget_hw_parameter_value $mhsinst "G_GET_USE_EXCEPTIONS"]
    set use_caches     [expr $use_icache || $use_dcache]
    set use_mmu        [expr $mmu_enabled && ! $area_optimized]
    set total_pages    [expr 3 + $use_exc + $debug + $use_caches + $use_mmu]
    set page_nr_list \
      [list 1 2 3 [expr 4 - !$use_exc] [expr 5 - !$use_exc - !$debug] \
       [expr 6 - !$use_exc - !$debug - !$use_caches]                  \
       [expr 7 - !$use_exc - !$debug - !$use_caches - !$use_mmu]]
    set page_nr [lindex $page_nr_list [expr $page - 1]]
    set page_title "Page $page_nr of $total_pages"
    gui_set_item $mhsinst "G_SET_STACKED_WIDGET_PAGE_TITLE" ""
    gui_set_item $mhsinst "G_SET_STACKED_WIDGET_PAGE_TITLE" $page_title
    set ::gui_prev_wizard_page $page
  }
  # puts "DEBUG: showing wizard page ${page}"
}

# Change which exceptions are enabled depending on selected configuration
proc gui_set_exception_enable {mhsinst} {
  set use_div                [xget_hw_parameter_value $mhsinst "C_USE_DIV"]
  set use_fpu                [xget_hw_parameter_value $mhsinst "C_USE_FPU"]
  set fsl_links              [xget_hw_parameter_value $mhsinst "C_FSL_LINKS"]
  set use_extended_fsl_instr [xget_hw_parameter_value $mhsinst "C_USE_EXTENDED_FSL_INSTR"]
  set ill_opcode_exception   [xget_hw_parameter_value $mhsinst "C_ILL_OPCODE_EXCEPTION"]

  gui_set_item $mhsinst "G_SET_DIV_ZERO_EXCEPTION_ENABLE"          $use_div
  gui_set_item $mhsinst "G_SET_DIV_ZERO_EXCEPTION_ENABLE_BOOL"     $use_div
  gui_set_item $mhsinst "G_SET_FPU_EXCEPTION_ENABLE"               [expr $use_fpu > 0]
  gui_set_item $mhsinst "G_SET_FPU_EXCEPTION_ENABLE_BOOL"          [expr $use_fpu > 0]
  gui_set_item $mhsinst "G_SET_USE_EXTENDED_FSL_INSTR_ENABLE"      [expr $fsl_links > 0]
  gui_set_item $mhsinst "G_SET_USE_EXTENDED_FSL_INSTR_ENABLE_BOOL" [expr $fsl_links > 0]
  gui_set_item $mhsinst "G_SET_FSL_EXCEPTION_ENABLE"               [expr $use_extended_fsl_instr && $fsl_links > 0]
  gui_set_item $mhsinst "G_SET_FSL_EXCEPTION_ENABLE_BOOL"          [expr $use_extended_fsl_instr && $fsl_links > 0]
  gui_set_item $mhsinst "G_SET_OPCODE_0X0_ILLEGAL_ENABLE"          $ill_opcode_exception
  # puts "DEBUG: set_exception enable: $use_div [expr !$use_div] $use_fpu=[expr $use_fpu > 0] $use_extended_fsl_instr $fsl_links $ill_opcode_exception"
}

# Change enable of "Use Memory Management", Branch Target Cache settings, "I-Cache Streams",
# "I-Cache Victims" and "D-Cache Victims" according to "Area_Optimized" setting
proc gui_set_area_opt {mhsinst} {
  set area_optimized [xget_hw_parameter_value $mhsinst "C_AREA_OPTIMIZED"]
  set use_writeback  [xget_hw_parameter_value $mhsinst "C_DCACHE_USE_WRITEBACK"]
  gui_set_item $mhsinst "G_SET_BRANCH_TARGET_ENABLE" [expr $area_optimized == 0]
  gui_set_item $mhsinst "G_SET_ICACHE_STREAMS_VICTIMS_ENABLE" [expr $area_optimized == 0]
  gui_set_item $mhsinst "G_SET_DCACHE_VICTIMS_ENABLE" [expr $area_optimized == 0 && $use_writeback == 1]
  gui_set_item $mhsinst "G_SET_MMU_ENABLE"            [expr $area_optimized == 0]
}

# Change value of checkbox "Branch Target Cache Size" in wizard according to settings
proc gui_set_branch_target_cache_size {mhsinst} {
  set branch_target_cache_size [xget_hw_parameter_value $mhsinst "C_BRANCH_TARGET_CACHE_SIZE"]
  gui_set_item $mhsinst "G_SET_BRANCH_TARGET_CACHE_SIZE" $branch_target_cache_size
  gui_set_item $mhsinst "G_GET_BRANCH_TARGET_CACHE_SIZE" $branch_target_cache_size
}

# Change value of checkbox "Enable Integer Multiplier" in wizard according to settings
proc gui_set_use_hw_mul {mhsinst} {
  set use_hw_mul [xget_hw_parameter_value $mhsinst "C_USE_HW_MUL"]
  gui_set_item $mhsinst "G_SET_USE_HW_MUL" $use_hw_mul
  gui_set_item $mhsinst "G_GET_USE_HW_MUL" $use_hw_mul
}

# Change value of checkbox "Enable Integer Divider" in wizard according to settings
proc gui_set_use_div {mhsinst} {
  set use_hw_mul [xget_hw_parameter_value $mhsinst "C_USE_DIV"]
  gui_set_item $mhsinst "G_SET_USE_DIV" $use_hw_mul
  gui_set_item $mhsinst "G_GET_USE_DIV" $use_hw_mul
}

# Change value of checkbox "Enable Floating Point Unit" in wizard according to settings
proc gui_set_use_fpu {mhsinst} {
  set use_fpu [xget_hw_parameter_value $mhsinst "C_USE_FPU"]
  gui_set_item $mhsinst "G_SET_USE_FPU" $use_fpu
  gui_set_item $mhsinst "G_GET_USE_FPU" $use_fpu
}

# Change which bus exceptions are shown depending on selected interconnect
proc gui_set_bus_exceptions {mhsinst} {
  set interconnect [xget_hw_parameter_value $mhsinst "C_INTERCONNECT"]
  if {$interconnect == 1} {
    gui_set_item $mhsinst "G_SET_BUS_EXCEPTIONS_PAGE" 0
    # puts "DEBUG: Showing PLB bus exceptions"
    set d_bus_exception [xget_hw_parameter_value $mhsinst "C_DPLB_BUS_EXCEPTION"]
    set i_bus_exception [xget_hw_parameter_value $mhsinst "C_IPLB_BUS_EXCEPTION"]
  } else {
    gui_set_item $mhsinst "G_SET_BUS_EXCEPTIONS_PAGE" 1
    # puts "DEBUG: Showing AXI bus exceptions"
    set d_bus_exception [xget_hw_parameter_value $mhsinst "C_M_AXI_D_BUS_EXCEPTION"]
    set i_bus_exception [xget_hw_parameter_value $mhsinst "C_M_AXI_I_BUS_EXCEPTION"]
  }
  gui_set_item $mhsinst "G_SET_D_BUS_EXCEPTION" $d_bus_exception
  gui_set_item $mhsinst "G_GET_D_BUS_EXCEPTION" $d_bus_exception
  gui_set_item $mhsinst "G_SET_I_BUS_EXCEPTION" $i_bus_exception
  gui_set_item $mhsinst "G_GET_I_BUS_EXCEPTION" $i_bus_exception
  # puts "DEBUG: Set D_BUS_EXCEPTION=$d_bus_exception, I_BUS_EXCEPTION=$i_bus_exception"
}

# Change value of checkbox "Enable Debug" in wizard according to debug settings
proc gui_set_debug_enabled {mhsinst} {
  set debug_enabled [xget_hw_parameter_value $mhsinst "C_DEBUG_ENABLED"]
  gui_set_item $mhsinst "G_SET_DEBUG_ENABLED" $debug_enabled
}

# Change value of checkbox "Use Instruction and Data Caches" according to cache settings
proc gui_set_use_caches {mhsinst} {
  set use_icache [xget_hw_parameter_value $mhsinst "C_USE_ICACHE"]
  set use_dcache [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]
  gui_set_item $mhsinst "G_SET_USE_CACHES" [expr $use_icache || $use_dcache]
}

# Change value of "* Cache * Address" according to cache settings
proc gui_set_cache_settings {mhsinst} {
  array set cache_byte_sizes \
    {64 0  128 1  256 2  512 3  1024 4 2048 5  4096 6  8192 7  16384 8  32768 9  65536 10}
  array set cache_victim_sizes {0 0  2 1  4 2  8 3}

  set cache_byte_size  [xget_hw_parameter_value $mhsinst "C_CACHE_BYTE_SIZE"]
  set icache_line_len  [xget_hw_parameter_value $mhsinst "C_ICACHE_LINE_LEN"]
  set icache_baseaddr  [xget_hw_parameter_value $mhsinst "C_ICACHE_BASEADDR"]
  set icache_highaddr  [xget_hw_parameter_value $mhsinst "C_ICACHE_HIGHADDR"]
  set icache_streams   [xget_hw_parameter_value $mhsinst "C_ICACHE_STREAMS"]
  set icache_victims   [xget_hw_parameter_value $mhsinst "C_ICACHE_VICTIMS"]

  set dcache_byte_size [xget_hw_parameter_value $mhsinst "C_DCACHE_BYTE_SIZE"]
  set dcache_line_len  [xget_hw_parameter_value $mhsinst "C_DCACHE_LINE_LEN"]
  set dcache_baseaddr  [xget_hw_parameter_value $mhsinst "C_DCACHE_BASEADDR"]
  set dcache_highaddr  [xget_hw_parameter_value $mhsinst "C_DCACHE_HIGHADDR"]
  set dcache_victims   [xget_hw_parameter_value $mhsinst "C_DCACHE_VICTIMS"]

  gui_set_item $mhsinst "G_SET_CACHE_BYTE_SIZE" $cache_byte_sizes($cache_byte_size)
  gui_set_item $mhsinst "G_GET_CACHE_BYTE_SIZE" $cache_byte_sizes($cache_byte_size)
  gui_set_item $mhsinst "G_SET_ICACHE_LINE_LEN" [expr $icache_line_len / 4 - 1]
  gui_set_item $mhsinst "G_GET_ICACHE_LINE_LEN" [expr $icache_line_len / 4 - 1]
  gui_set_item $mhsinst "C_ICACHE_BASEADDR" ""
  gui_set_item $mhsinst "C_ICACHE_BASEADDR" $icache_baseaddr
  gui_set_item $mhsinst "C_ICACHE_HIGHADDR" ""
  gui_set_item $mhsinst "C_ICACHE_HIGHADDR" $icache_highaddr
  gui_set_item $mhsinst "G_SET_ICACHE_BASEADDR" ""
  gui_set_item $mhsinst "G_SET_ICACHE_BASEADDR" $icache_baseaddr
  gui_set_item $mhsinst "G_SET_ICACHE_HIGHADDR" ""
  gui_set_item $mhsinst "G_SET_ICACHE_HIGHADDR" $icache_highaddr
  gui_set_item $mhsinst "G_SET_ICACHE_STREAMS" $icache_streams
  gui_set_item $mhsinst "G_GET_ICACHE_STREAMS" $icache_streams
  gui_set_item $mhsinst "G_SET_ICACHE_VICTIMS" $cache_victim_sizes($icache_victims)
  gui_set_item $mhsinst "G_GET_ICACHE_VICTIMS" $cache_victim_sizes($icache_victims)

  gui_set_item $mhsinst "G_SET_DCACHE_BYTE_SIZE" $cache_byte_sizes($dcache_byte_size)
  gui_set_item $mhsinst "G_GET_DCACHE_BYTE_SIZE" $cache_byte_sizes($dcache_byte_size)
  gui_set_item $mhsinst "G_SET_DCACHE_LINE_LEN" [expr $dcache_line_len / 4 - 1]
  gui_set_item $mhsinst "G_GET_DCACHE_LINE_LEN" [expr $dcache_line_len / 4 - 1]
  gui_set_item $mhsinst "C_DCACHE_BASEADDR" ""
  gui_set_item $mhsinst "C_DCACHE_BASEADDR" $dcache_baseaddr
  gui_set_item $mhsinst "C_DCACHE_HIGHADDR" ""
  gui_set_item $mhsinst "C_DCACHE_HIGHADDR" $dcache_highaddr
  gui_set_item $mhsinst "G_SET_DCACHE_BASEADDR" ""
  gui_set_item $mhsinst "G_SET_DCACHE_BASEADDR" $icache_baseaddr
  gui_set_item $mhsinst "G_SET_DCACHE_HIGHADDR" ""
  gui_set_item $mhsinst "G_SET_DCACHE_HIGHADDR" $icache_highaddr
  gui_set_item $mhsinst "G_SET_DCACHE_VICTIMS" $cache_victim_sizes($dcache_victims)
  gui_set_item $mhsinst "G_GET_DCACHE_VICTIMS" $cache_victim_sizes($dcache_victims)
  # puts "DEBUG: Set G_CACHE_BYTE_SIZE=$cache_byte_sizes($cache_byte_size)"
  # puts "DEBUG: Set G_DCACHE_BYTE_SIZE=$cache_byte_sizes($dcache_byte_size)"
  # puts "DEBUG: Set G_ICACHE_STREAMS=$icache_streams"
  # puts "DEBUG: Set G_ICACHE_VITIMS=$cache_victim_sizes($icache_victims), $icache_victims"
  # puts "DEBUG: Set G_DCACHE_VITIMS=$cache_victim_sizes($dcache_victims), $dcache_victims"
}

# Change value of checkbox "Use Memory Management" in wizard according to MMU settings
proc gui_set_mmu_enabled {mhsinst} {
  set use_mmu [xget_hw_parameter_value $mhsinst "C_USE_MMU"]
  set area_optimized [xget_hw_parameter_value $mhsinst "C_AREA_OPTIMIZED"]
  gui_set_item $mhsinst "G_SET_MMU_ENABLED" [expr $use_mmu > 0 && $area_optimized == 0]
  gui_set_item $mhsinst "G_GET_MMU_ENABLED" [expr $use_mmu > 0 && $area_optimized == 0]
  gui_set_item $mhsinst "G_SET_MMU_ITEMS_ENABLE" [expr $use_mmu > 1]
}

# Change value of mmu settings according to settings
proc gui_set_mmu_settings {mhsinst} {
  array set tlb_sizes {1 0  2 1  4 2  8 3}
  set use_mmu        [xget_hw_parameter_value $mhsinst "C_USE_MMU"]
  set mmu_dtlb_size  [xget_hw_parameter_value $mhsinst "C_MMU_DTLB_SIZE"]
  set mmu_itlb_size  [xget_hw_parameter_value $mhsinst "C_MMU_ITLB_SIZE"]
  set mmu_tlb_access [xget_hw_parameter_value $mhsinst "C_MMU_TLB_ACCESS"]
  set mmu_zones      [xget_hw_parameter_value $mhsinst "C_MMU_ZONES"]
  gui_set_item $mhsinst "G_SET_USE_MMU" $use_mmu
  gui_set_item $mhsinst "G_GET_USE_MMU" $use_mmu
  gui_set_item $mhsinst "G_SET_MMU_DTLB_SIZE" $tlb_sizes($mmu_dtlb_size)
  gui_set_item $mhsinst "G_GET_MMU_DTLB_SIZE" $tlb_sizes($mmu_dtlb_size)
  gui_set_item $mhsinst "G_SET_MMU_ITLB_SIZE" $tlb_sizes($mmu_itlb_size)
  gui_set_item $mhsinst "G_GET_MMU_ITLB_SIZE" $tlb_sizes($mmu_itlb_size)
  gui_set_item $mhsinst "G_SET_MMU_TLB_ACCESS" $mmu_tlb_access
  gui_set_item $mhsinst "G_GET_MMU_TLB_ACCESS" $mmu_tlb_access
}

# Change value of checkbox "Use Exceptions" in wizard according to exception settings
proc gui_set_use_exc {mhsinst} {
  set div_zero_exc           [xget_hw_parameter_value $mhsinst "C_DIV_ZERO_EXCEPTION"]
  set use_div                [xget_hw_parameter_value $mhsinst "C_USE_DIV"]
  set daxi_bus_exc           [xget_hw_parameter_value $mhsinst "C_M_AXI_D_BUS_EXCEPTION"]
  set dplb_bus_exc           [xget_hw_parameter_value $mhsinst "C_DPLB_BUS_EXCEPTION"]
  set iaxi_bus_exc           [xget_hw_parameter_value $mhsinst "C_M_AXI_I_BUS_EXCEPTION"]
  set iplb_bus_exc           [xget_hw_parameter_value $mhsinst "C_IPLB_BUS_EXCEPTION"]
  set ill_opcode_exc         [xget_hw_parameter_value $mhsinst "C_ILL_OPCODE_EXCEPTION"]
  set fpu_exc                [xget_hw_parameter_value $mhsinst "C_FPU_EXCEPTION"]
  set use_fpu                [xget_hw_parameter_value $mhsinst "C_USE_FPU"]
  set fsl_exc                [xget_hw_parameter_value $mhsinst "C_FSL_EXCEPTION"]
  set use_extended_fsl_instr [xget_hw_parameter_value $mhsinst "C_USE_EXTENDED_FSL_INSTR"]
  set unaligned_exc          [xget_hw_parameter_value $mhsinst "C_UNALIGNED_EXCEPTIONS"]

  set use_exc [expr ($div_zero_exc && $use_div) || $daxi_bus_exc || $dplb_bus_exc || \
    $iaxi_bus_exc || $iplb_bus_exc || $ill_opcode_exc || ($fpu_exc && $use_fpu) || \
    ($fsl_exc && $use_extended_fsl_instr) || $unaligned_exc]

  gui_set_item $mhsinst "G_SET_USE_EXCEPTIONS" $use_exc
  gui_set_item $mhsinst "G_GET_USE_EXCEPTIONS" $use_exc
  # puts "DEBUG: set_use_exc \"${use_exc}\""
}

# Change bus exception settings in wizard
proc gui_set_bus_exc {mhsinst} {
  gui_set_use_exc $mhsinst
  gui_set_bus_exceptions $mhsinst
}

# Change value of checkbox "Select Bus Interface" and "Number of FSL Links" in wizard
# according to bus settings
proc gui_set_buses {mhsinst} {
  set interconnect [xget_hw_parameter_value $mhsinst "C_INTERCONNECT"]
  set stream_interconnect [xget_hw_parameter_value $mhsinst "C_STREAM_INTERCONNECT"]
  set fsl_links [xget_hw_parameter_value $mhsinst "C_FSL_LINKS"]
  gui_set_item $mhsinst "G_SET_INTERCONNECT" [expr $interconnect - 1]
  gui_set_item $mhsinst "G_GET_INTERCONNECT" [expr $interconnect - 1]
  gui_set_item $mhsinst "G_SET_STREAM_INTERCONNECT" $stream_interconnect
  gui_set_item $mhsinst "G_GET_STREAM_INTERCONNECT" $stream_interconnect
  gui_set_item $mhsinst "G_SET_FSL_LINKS" $fsl_links
  gui_set_item $mhsinst "G_GET_FSL_LINKS" $fsl_links

  set pvr       [xget_hw_parameter_value $mhsinst "C_PVR"]
  set pvr_user1 [xget_hw_parameter_value $mhsinst "C_PVR_USER1"]
  set pvr_user2 [xget_hw_parameter_value $mhsinst "C_PVR_USER2"]
  gui_set_item $mhsinst "G_SET_PVR"       $pvr
  gui_set_item $mhsinst "G_GET_PVR"       $pvr
  gui_set_item $mhsinst "G_SET_PVR_USER1" $pvr_user1
  gui_set_item $mhsinst "G_SET_PVR_USER2" $pvr_user2
  gui_set_item $mhsinst "G_SET_PVR_USER1_ENABLE"      [expr $pvr > 0]
  gui_set_item $mhsinst "G_SET_PVR_USER1_ENABLE_BOOL" [expr $pvr > 0]
  gui_set_item $mhsinst "G_SET_PVR_USER2_ENABLE"      [expr $pvr > 1]
  gui_set_item $mhsinst "G_SET_PVR_USER2_ENABLE_BOOL" [expr $pvr > 1]
}

# Check if caches are connected, and save information for use in performance calculation
proc gui_init_buses {mhsinst} {
  set interconnect [xget_hw_parameter_value $mhsinst "C_INTERCONNECT"]
  if {$interconnect == 1} {
    set ::icache_bus [bus_is_defined $mhsinst "IXCL"]
    set ::dcache_bus [bus_is_defined $mhsinst "DXCL"]
  } else {
    set ::icache_bus [bus_is_defined $mhsinst "M_AXI_IC"]
    set ::dcache_bus [bus_is_defined $mhsinst "M_AXI_DC"]
  }
  set ::debug_bus [bus_is_defined $mhsinst "DEBUG"]
}

# Change illegal onstruction exception settings in wizard
proc gui_set_ill_opc_exc {mhsinst} {
  set ill_opcode_exception [xget_hw_parameter_value $mhsinst "C_ILL_OPCODE_EXCEPTION"]
  gui_set_item $mhsinst "G_SET_OPCODE_0X0_ILLEGAL_ENABLE" $ill_opcode_exception
  gui_set_use_exc $mhsinst
}

# Initialization procedures for "microblaze_v2_1_0.ui", automatically called when the dialog is opened
proc xps_ipconfig_init {mhsinst} {
  set family [xget_hw_parameter_value $mhsinst "C_FAMILY"]
  config_read_data $mhsinst $family

  gui_set $mhsinst "all"
  gui_init_template $mhsinst 0

  gui_set_area_opt $mhsinst
  gui_set_branch_target_cache_size $mhsinst
  gui_set_use_hw_mul $mhsinst
  gui_set_use_div $mhsinst
  gui_set_use_fpu $mhsinst
  gui_set_bus_exceptions $mhsinst
  gui_set_exception_enable $mhsinst
  gui_set_debug_enabled $mhsinst
  gui_set_use_caches $mhsinst
  gui_set_cache_settings $mhsinst
  gui_set_mmu_enabled $mhsinst
  gui_set_mmu_settings $mhsinst
  gui_set_use_exc $mhsinst
  gui_set_buses $mhsinst
  gui_init_buses $mhsinst

  gui_set_item $mhsinst "G_GET_ADVANCED_BUTTON"
  gui_set_item $mhsinst "G_GET_WIZARD_BUTTON"
  gui_set_item $mhsinst "G_GET_NEXT_1_BUTTON"
  gui_set_item $mhsinst "G_GET_NEXT_2_BUTTON"
  gui_set_item $mhsinst "G_GET_NEXT_3_BUTTON"
  gui_set_item $mhsinst "G_GET_NEXT_4_BUTTON"
  gui_set_item $mhsinst "G_GET_NEXT_5_BUTTON"
  gui_set_item $mhsinst "G_GET_NEXT_6_BUTTON"
  gui_set_item $mhsinst "G_GET_BACK_2_BUTTON"
  gui_set_item $mhsinst "G_GET_BACK_3_BUTTON"
  gui_set_item $mhsinst "G_GET_BACK_4_BUTTON"
  gui_set_item $mhsinst "G_GET_BACK_5_BUTTON"
  gui_set_item $mhsinst "G_GET_BACK_6_BUTTON"
  gui_set_item $mhsinst "G_GET_BACK_7_BUTTON"
  gui_set_item $mhsinst "G_GET_FIRST_BUTTON"
  gui_set_item $mhsinst "G_GET_TEMPLATE_LIST_CURRENT_ROW" 0
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another template in the dialog
proc gui_template_list_current_row_changed {mhsinst} {
  set template_list_handle [xget_hw_parameter_handle $mhsinst "G_GET_TEMPLATE_LIST_CURRENT_ROW"]
  set current_row [xget_hw_value $template_list_handle]
  if {$current_row < 0 || $current_row >= [llength $::config_template_data]} {
    return
  }
  gui_set_template $mhsinst $current_row

  if {$current_row == 0} {
    puts "Restored current MicroBlaze settings"
  } else {
    set template_name [lindex [lindex [lindex $::config_template_data $current_row] 0] 0]
    puts "Changed MicroBlaze settings according to template \"$template_name\""
    gui_check_warn_debug $mhsinst
  }

  gui_set_branch_target_cache_size $mhsinst
  gui_set_use_hw_mul $mhsinst
  gui_set_use_div $mhsinst
  gui_set_use_fpu $mhsinst
  gui_set_bus_exceptions $mhsinst
  gui_set_exception_enable $mhsinst
  gui_set_debug_enabled $mhsinst
  gui_set_use_caches $mhsinst
  gui_set_cache_settings $mhsinst
  gui_set_mmu_enabled $mhsinst
  gui_set_mmu_settings $mhsinst
  gui_set_use_exc $mhsinst
  gui_set_buses $mhsinst
  # puts "DEBUG: template list current row = \"${current_row}\""
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user changes "Use Memory Management" on the first page of the wizard
proc gui_mmu_enabled_changed {mhsinst} {
  set use_mmu [xget_hw_parameter_value $mhsinst "C_USE_MMU"]
  set get_mmu_enabled_handle [xget_hw_parameter_handle $mhsinst "G_GET_MMU_ENABLED"]
  set new_value [xget_hw_value $get_mmu_enabled_handle]
  if {$new_value == 1 && $use_mmu == 0} {
    # Set MMU to VIRTUAL if it is set to NONE
    gui_set_item $mhsinst "G_SET_USE_MMU" 3
    gui_set_item $mhsinst "G_GET_USE_MMU" 3
    gui_set_item $mhsinst "C_USE_MMU" 3
    gui_set $mhsinst "mmu_enabled_changed"
  }
  if {$new_value == 0} {
    # Set MMU to NONE
    gui_set_item $mhsinst "G_SET_USE_MMU" 0
    gui_set_item $mhsinst "G_GET_USE_MMU" 0
    gui_set_item $mhsinst "C_USE_MMU" 0
    gui_set $mhsinst "mmu_enabled_changed"
  }
  # puts "DEBUG: C_MMU_ENABLED setting changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another BTC size setting in the wizard
proc gui_branch_target_cache_size_changed {mhsinst} {
  set get_btc_size_handle [xget_hw_parameter_handle $mhsinst "G_GET_BRANCH_TARGET_CACHE_SIZE"]
  set new_value [xget_hw_value $get_btc_size_handle]
  gui_set_item $mhsinst "G_SET_BRANCH_TARGET_CACHE_SIZE" $new_value
  gui_set_item $mhsinst "C_BRANCH_TARGET_CACHE_SIZE" $new_value
  gui_set $mhsinst "branch_target_cache_size_changed"
  # puts "DEBUG: C_BRANCH_TARGET_CACHE_SIZE setting changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another FPU setting in the wizard
proc gui_use_fpu_changed {mhsinst} {
  set get_use_fpu_handle [xget_hw_parameter_handle $mhsinst "G_GET_USE_FPU"]
  set new_value [xget_hw_value $get_use_fpu_handle]
  gui_set_item $mhsinst "C_USE_FPU" $new_value
  gui_set_item $mhsinst "G_SET_FPU_EXCEPTION_ENABLE" [expr $new_value > 0]
  gui_set_item $mhsinst "G_SET_FPU_EXCEPTION_ENABLE_BOOL" [expr $new_value > 0]
  gui_set $mhsinst "use_fpu_changed"
  # puts "DEBUG: C_USE_FPU setting changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another HW_MUL setting in the wizard
proc gui_use_hw_mul_changed {mhsinst} {
  set get_use_hw_mul_handle [xget_hw_parameter_handle $mhsinst "G_GET_USE_HW_MUL"]
  set new_value [xget_hw_value $get_use_hw_mul_handle]
  gui_set_item $mhsinst "C_USE_HW_MUL" $new_value
  gui_set $mhsinst "hw_mul_changed"
  # puts "DEBUG: C_USE_HW_MUL setting changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another DIV setting in the wizard
proc gui_use_div_changed {mhsinst} {
  set get_use_div_handle [xget_hw_parameter_handle $mhsinst "G_GET_USE_DIV"]
  set new_value [xget_hw_value $get_use_div_handle]
  gui_set_item $mhsinst "C_USE_DIV" $new_value
  gui_set_item $mhsinst "G_SET_DIV_ZERO_EXCEPTION_ENABLE" $new_value
  gui_set $mhsinst "use_div_changed"
  # puts "DEBUG: C_USE_DIV setting changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another Data Bus Exception setting in the wizard
proc gui_d_bus_exception_changed {mhsinst} {
  set get_d_bus_exception_handle [xget_hw_parameter_handle $mhsinst "G_GET_D_BUS_EXCEPTION"]
  set new_value [xget_hw_value $get_d_bus_exception_handle]
  set interconnect [xget_hw_parameter_value $mhsinst "C_INTERCONNECT"]
  if {$interconnect == 1} {
    gui_set_item $mhsinst "C_DPLB_BUS_EXCEPTION" $new_value
  } else {
    gui_set_item $mhsinst "C_M_AXI_D_BUS_EXCEPTION" $new_value
  }
  gui_set $mhsinst "d_bus_exception_changed"
  # puts "DEBUG: C_D_BUS_EXCEPTION setting changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another Instruction Bus Exception setting in the wizard
proc gui_i_bus_exception_changed {mhsinst} {
  set get_i_bus_exception_handle [xget_hw_parameter_handle $mhsinst "G_GET_I_BUS_EXCEPTION"]
  set new_value [xget_hw_value $get_i_bus_exception_handle]
  set interconnect [xget_hw_parameter_value $mhsinst "C_INTERCONNECT"]
  if {$interconnect == 1} {
    gui_set_item $mhsinst "C_IPLB_BUS_EXCEPTION" $new_value
  } else {
    gui_set_item $mhsinst "C_M_AXI_I_BUS_EXCEPTION" $new_value
  }
  gui_set $mhsinst "i_bus_exception_changed"
  # puts "DEBUG: C_I_BUS_EXCEPTION setting changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another icache byte size setting in the wizard
proc gui_cache_byte_size_changed {mhsinst} {
  set get_cache_byte_size_handle [xget_hw_parameter_handle $mhsinst "G_GET_CACHE_BYTE_SIZE"]
  set new_value [xget_hw_value $get_cache_byte_size_handle]
  set c_new_value [expr int(pow(2, 6 + $new_value))]
  gui_set_item $mhsinst "C_CACHE_BYTE_SIZE" $c_new_value
  gui_set $mhsinst "cache_byte_size_changed"
  # puts "DEBUG: cache_byte_size_changed: $new_value, $c_new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another icache line setting in the wizard
proc gui_icache_line_len_changed {mhsinst} {
  set get_icache_line_len_handle [xget_hw_parameter_handle $mhsinst "G_GET_ICACHE_LINE_LEN"]
  set new_value [xget_hw_value $get_icache_line_len_handle]
  gui_set_item $mhsinst "C_ICACHE_LINE_LEN" [expr ($new_value + 1) * 4]
  gui_set_bram_size $mhsinst  
  gui_set $mhsinst "icache_line_len_changed"
  # puts "DEBUG: icache_line_len_changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another icache streams setting in the wizard
proc gui_icache_streams_changed {mhsinst} {
  set get_icache_streams_handle [xget_hw_parameter_handle $mhsinst "G_GET_ICACHE_STREAMS"]
  set new_value [xget_hw_value $get_icache_streams_handle]
  gui_set_item $mhsinst "C_ICACHE_STREAMS" $new_value
  gui_set $mhsinst "icache_streams_changed"
  # puts "DEBUG: icache_streams_changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another icache victims setting in the wizard
proc gui_icache_victims_changed {mhsinst} {
  array set cache_victim_sizes_rev {0 0  1 2  2 4  3 8}
  set get_icache_victims_handle [xget_hw_parameter_handle $mhsinst "G_GET_ICACHE_VICTIMS"]
  set new_value [xget_hw_value $get_icache_victims_handle]
  gui_set_item $mhsinst "G_SET_ICACHE_VICTIMS" $new_value
  gui_set_item $mhsinst "C_ICACHE_VICTIMS" $cache_victim_sizes_rev($new_value)
  gui_set $mhsinst "icache_victims_changed"
  # puts "DEBUG: icache_victims_changed: $new_value $cache_victim_sizes_rev($new_value)"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another dcache byte size setting in the wizard
proc gui_dcache_byte_size_changed {mhsinst} {
  set get_dcache_byte_size_handle [xget_hw_parameter_handle $mhsinst "G_GET_DCACHE_BYTE_SIZE"]
  set new_value [xget_hw_value $get_dcache_byte_size_handle]
  set c_new_value [expr int(pow(2, 6 + $new_value))]
  gui_set_item $mhsinst "C_DCACHE_BYTE_SIZE" $c_new_value
  gui_set $mhsinst "dcache_byte_size_changed"
  # puts "DEBUG: dcache_byte_size_changed: $new_value, $c_new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another dcache line setting in the wizard
proc gui_dcache_line_len_changed {mhsinst} {
  set get_dcache_line_len_handle [xget_hw_parameter_handle $mhsinst "G_GET_DCACHE_LINE_LEN"]
  set new_value [xget_hw_value $get_dcache_line_len_handle]
  gui_set_item $mhsinst "C_DCACHE_LINE_LEN" [expr ($new_value + 1) * 4]
  gui_set_bram_size $mhsinst  
  gui_set $mhsinst "dcache_line_len_changed"
  # puts "DEBUG: dcache_line_len_changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another dcache victims setting in the wizard
proc gui_dcache_victims_changed {mhsinst} {
  array set cache_victim_sizes_rev {0 0  1 2  2 4  3 8}
  set get_dcache_victims_handle [xget_hw_parameter_handle $mhsinst "G_GET_DCACHE_VICTIMS"]
  set new_value [xget_hw_value $get_dcache_victims_handle]
  gui_set_item $mhsinst "G_SET_DCACHE_VICTIMS" $new_value
  gui_set_item $mhsinst "C_DCACHE_VICTIMS" $cache_victim_sizes_rev($new_value)
  gui_set $mhsinst "dcache_victims_changed"
  # puts "DEBUG: dcache_victims_changed: $new_value $cache_victim_sizes_rev($new_value)"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another mmu setting in the wizard
proc gui_use_mmu_changed {mhsinst} {
  set get_use_mmu_handle [xget_hw_parameter_handle $mhsinst "G_GET_USE_MMU"]
  set new_value [xget_hw_value $get_use_mmu_handle]
  gui_set_item $mhsinst "C_USE_MMU" $new_value
  gui_set_mmu_enabled $mhsinst
  gui_set $mhsinst "use_mmu_changed"
  # puts "DEBUG: use_mmu_changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another mmu dtlb size setting in the wizard
proc gui_mmu_dtlb_size_changed {mhsinst} {
  set get_mmu_dtlb_size_handle [xget_hw_parameter_handle $mhsinst "G_GET_MMU_DTLB_SIZE"]
  set new_value [xget_hw_value $get_mmu_dtlb_size_handle]
  set c_new_value [expr int(pow(2, $new_value))]
  gui_set_item $mhsinst "C_MMU_DTLB_SIZE" $c_new_value
  gui_set $mhsinst "mmu_dtlb_size_changed"
  # puts "DEBUG: mmu_dtlb_size_changed: $new_value, $c_new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another mmu itlb size setting in the wizard
proc gui_mmu_itlb_size_changed {mhsinst} {
  set get_mmu_itlb_size_handle [xget_hw_parameter_handle $mhsinst "G_GET_MMU_ITLB_SIZE"]
  set new_value [xget_hw_value $get_mmu_itlb_size_handle]
  set c_new_value [expr int(pow(2, $new_value))]
  gui_set_item $mhsinst "C_MMU_ITLB_SIZE" $c_new_value
  gui_set $mhsinst "mmu_itlb_size_changed"
  # puts "DEBUG: mmu_itlb_size_changed: $new_value, $c_new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another mmu tlb access setting in the wizard
proc gui_mmu_tlb_access_changed {mhsinst} {
  set get_mmu_tlb_access_handle [xget_hw_parameter_handle $mhsinst "G_GET_MMU_TLB_ACCESS"]
  set new_value [xget_hw_value $get_mmu_tlb_access_handle]
  gui_set_item $mhsinst "C_MMU_TLB_ACCESS" $new_value
  gui_set $mhsinst "mmu_tlb_access_changed"
  # puts "DEBUG: mmu_tlb_access_changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another PVR setting in the wizard
proc gui_pvr_changed {mhsinst} {
  set get_pvr_handle [xget_hw_parameter_handle $mhsinst "G_GET_PVR"]
  set new_value      [xget_hw_value $get_pvr_handle]
  gui_set_item $mhsinst "C_PVR" $new_value
  gui_set_item $mhsinst "G_SET_PVR_USER1_ENABLE"      [expr $new_value > 0]
  gui_set_item $mhsinst "G_SET_PVR_USER1_ENABLE_BOOL" [expr $new_value > 0]
  gui_set_item $mhsinst "G_SET_PVR_USER2_ENABLE"      [expr $new_value > 1]
  gui_set_item $mhsinst "G_SET_PVR_USER2_ENABLE_BOOL" [expr $new_value > 1]
  gui_set $mhsinst "pvr_changed"
  # puts "DEBUG: pvr_changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another INTERCONNECT setting in the wizard
proc gui_interconnect_changed {mhsinst} {
  set get_interconnect_handle [xget_hw_parameter_handle $mhsinst "G_GET_INTERCONNECT"]
  set new_value [xget_hw_value $get_interconnect_handle]
  gui_set_item $mhsinst "C_INTERCONNECT" [expr $new_value + 1]
  gui_set_item $mhsinst "G_SET_INTERCONNECT" $new_value
  gui_set $mhsinst "interconnect_changed"
  gui_set_bus_exceptions $mhsinst
  gui_set_buses $mhsinst
  # puts "DEBUG: C_INTERCONNECT setting changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another STREAM_INTERCONNECT setting in the wizard
proc gui_stream_interconnect_changed {mhsinst} {
  set get_stream_interconnect_handle [xget_hw_parameter_handle $mhsinst "G_GET_STREAM_INTERCONNECT"]
  set new_value [xget_hw_value $get_stream_interconnect_handle]
  gui_set_item $mhsinst "C_STREAM_INTERCONNECT" $new_value
  gui_set_item $mhsinst "G_SET_STREAM_INTERCONNECT" $new_value
  gui_set $mhsinst "stream interconnect_changed"
  # puts "DEBUG: C_STREAM_INTERCONNECT setting changed: $new_value"
}

# Callback procedure from "microblaze_v2_1_0.ui"
# Called when the user selects another FSL link setting in the wizard
proc gui_fsl_links_changed {mhsinst} {
  set use_extended_fsl_instr [xget_hw_parameter_value $mhsinst "C_USE_EXTENDED_FSL_INSTR"]
  set get_fsl_links_handle   [xget_hw_parameter_handle $mhsinst "G_GET_FSL_LINKS"]
  set fsl_links              [xget_hw_parameter_value $mhsinst "C_FSL_LINKS"]
  set new_value              [xget_hw_value $get_fsl_links_handle]
  if {$new_value != $fsl_links} { gui_set_item $mhsinst "C_FSL_LINKS" $new_value }
  gui_set_item $mhsinst "G_SET_USE_EXTENDED_FSL_INSTR_ENABLE"      [expr $new_value > 0]
  gui_set_item $mhsinst "G_SET_USE_EXTENDED_FSL_INSTR_ENABLE_BOOL" [expr $new_value > 0]
  gui_set_item $mhsinst "G_SET_FSL_EXCEPTION_ENABLE"      [expr $use_extended_fsl_instr && $new_value > 0]
  gui_set_item $mhsinst "G_SET_FSL_EXCEPTION_ENABLE_BOOL" [expr $use_extended_fsl_instr && $new_value > 0]
  gui_set $mhsinst "fsl_links_changed"
  # puts "DEBUG: fsl_links_changed: $new_value $use_extended_fsl_instr [expr $use_extended_fsl_instr && $new_value > 0]"
}

proc gui_ext_fsl_changed {mhsinst} {
  set use_extended_fsl_instr [xget_hw_parameter_value $mhsinst "C_USE_EXTENDED_FSL_INSTR"]
  set fsl_links              [xget_hw_parameter_value $mhsinst "C_FSL_LINKS"]
  gui_set_item $mhsinst "G_SET_USE_EXTENDED_FSL_INSTR_ENABLE"      [expr $fsl_links > 0]
  gui_set_item $mhsinst "G_SET_USE_EXTENDED_FSL_INSTR_ENABLE_BOOL" [expr $fsl_links > 0]
  gui_set_item $mhsinst "G_SET_FSL_EXCEPTION_ENABLE"      [expr $use_extended_fsl_instr && $fsl_links > 0]
  gui_set_item $mhsinst "G_SET_FSL_EXCEPTION_ENABLE_BOOL" [expr $use_extended_fsl_instr && $fsl_links > 0]
  gui_set $mhsinst "ext_fsl_changed"
  # puts "DEBUG: fsl_ext_fsl_changed: $new_value $use_extended_fsl_instr [expr $use_extended_fsl_instr && $new_value > 0]"
}

# Callback procedures from "microblaze_v2_1_0.ui"
# These procedures are called when the user changes the value of a parameter in the dialog
proc gui_use_btc                {mhsinst} { gui_set $mhsinst "use_btc" }
proc gui_btc_size               {mhsinst} { gui_set $mhsinst "btc_size" }
proc gui_use_barrel             {mhsinst} { gui_set $mhsinst "use_barrel" }
proc gui_use_fpu                {mhsinst} { gui_set $mhsinst "use_fpu"    }
proc gui_use_hw_mul             {mhsinst} { gui_set $mhsinst "use_hw_mul" }
proc gui_use_div                {mhsinst} { gui_set $mhsinst "use_div" }
proc gui_use_msr_instr          {mhsinst} { gui_set $mhsinst "use_msr_instr" }
proc gui_use_pcmp_instr         {mhsinst} { gui_set $mhsinst "use_pcmp_instr" }
proc gui_use_extended_fsl_instr {mhsinst} { gui_set $mhsinst "use_ext_fsl" ; gui_ext_fsl_changed $mhsinst }
proc gui_area_optimized         {mhsinst} { gui_set $mhsinst "area_optimized" ; gui_set_area_opt $mhsinst }
proc gui_fpu_exception          {mhsinst} { gui_set $mhsinst "fpu_exception" ; gui_set_use_exc $mhsinst }
proc gui_div_zero_exception     {mhsinst} { gui_set $mhsinst "div_zero_exception" ; gui_set_use_exc $mhsinst }
proc gui_dplb_bus_exception     {mhsinst} { gui_set $mhsinst "dplb_bus_exception" ; gui_set_bus_exc $mhsinst }
proc gui_iplb_exception         {mhsinst} { gui_set $mhsinst "iplb_bus_exception" ; gui_set_bus_exc $mhsinst }
proc gui_daxi_bus_exception     {mhsinst} { gui_set $mhsinst "daxi_bus_exception" ; gui_set_bus_exc $mhsinst }
proc gui_iaxi_bus_exception     {mhsinst} { gui_set $mhsinst "iaxi_bus_exception" ; gui_set_bus_exc $mhsinst }
proc gui_ill_opcode_exception   {mhsinst} { gui_set $mhsinst "ill_opcode_exc" ; gui_set_ill_opc_exc $mhsinst }
proc gui_unaligned_exception    {mhsinst} { gui_set $mhsinst "unaligned_exception" ; gui_set_use_exc $mhsinst }
proc gui_opcode_0x0_illegal     {mhsinst} { gui_set $mhsinst "opcode_0x0_illegal" }
proc gui_fsl_exception          {mhsinst} { gui_set $mhsinst "fsl_exception" ; gui_set_use_exc $mhsinst }
proc gui_use_icache             {mhsinst} { gui_set $mhsinst "use_icache" ; gui_set_use_caches $mhsinst }
proc gui_cache_byte_size        {mhsinst} { gui_set $mhsinst "cache_byte_size" }
proc gui_icache_line_len        {mhsinst} { gui_set $mhsinst "icache_line_len" }
proc gui_icache_baseaddr        {mhsinst} { gui_set $mhsinst "icache_baseaddr" }
proc gui_icache_highaddr        {mhsinst} { gui_set $mhsinst "icache_highaddr" }
proc gui_icache_always_used     {mhsinst} { gui_set $mhsinst "icache_always_used" }
proc gui_icache_force_tag       {mhsinst} { gui_set $mhsinst "icache_force_tag_lutram" }
proc gui_icache_streams         {mhsinst} { gui_set $mhsinst "icache_streams" }
proc gui_icache_victims         {mhsinst} { gui_set $mhsinst "icache_victims" ; gui_set_cache_settings $mhsinst}
proc gui_use_dcache             {mhsinst} { gui_set $mhsinst "use_dcache" ; gui_set_use_caches $mhsinst }
proc gui_dcache_byte_size       {mhsinst} { gui_set $mhsinst "dcache_byte_size" }
proc gui_dcache_line_len        {mhsinst} { gui_set $mhsinst "dcache_line_len" }
proc gui_dcache_baseaddr        {mhsinst} { gui_set $mhsinst "dcache_baseaddr" }
proc gui_dcache_highaddr        {mhsinst} { gui_set $mhsinst "dcache_highaddr" }
proc gui_dcache_always_used     {mhsinst} { gui_set $mhsinst "dcache_always_used" }
proc gui_dcache_force_tag       {mhsinst} { gui_set $mhsinst "dcache_force_tag_lutram" }
proc gui_dcache_use_writeback   {mhsinst} { gui_set $mhsinst "dcache_use_writeback" ; gui_set_area_opt $mhsinst }
proc gui_dcache_victims         {mhsinst} { gui_set $mhsinst "dcache_victims" ; gui_set_cache_settings $mhsinst}
proc gui_use_mmu                {mhsinst} { gui_set $mhsinst "use_mmu" ; gui_set_mmu_enabled $mhsinst }
proc gui_mmu_dtlb_size          {mhsinst} { gui_set $mhsinst "mmu_dtlb_size" }
proc gui_mmu_itlb_size          {mhsinst} { gui_set $mhsinst "mmu_itlb_size" }
proc gui_mmu_tlb_access         {mhsinst} { gui_set $mhsinst "mmu_tlb_access" }
proc gui_mmu_zones              {mhsinst} { gui_set $mhsinst "mmu_zones" }
proc gui_debug_enabled          {mhsinst} { gui_set $mhsinst "debug_enabled" ; gui_set_debug_enabled $mhsinst }
proc gui_number_of_pc_brk       {mhsinst} { gui_set $mhsinst "number_of_pc_brk" }
proc gui_number_of_wr_addr_brk  {mhsinst} { gui_set $mhsinst "number_of_wr_addr_brk" }
proc gui_number_of_rd_addr_brk  {mhsinst} { gui_set $mhsinst "number_of_rd_addr_brk" }
proc gui_reset_msr              {mhsinst} { gui_set $mhsinst "reset_msr" }
proc gui_fsl_links              {mhsinst} { gui_set $mhsinst "fsl_links" }
proc gui_interconnect           {mhsinst} {
  gui_set $mhsinst "interconnect" ; gui_set_bus_exceptions $mhsinst ; gui_set_buses $mhsinst
}
proc gui_stream_interconnect    {mhsinst} {
  gui_set $mhsinst "stream interconnect" ; gui_set_buses $mhsinst
}
proc gui_pvr                    {mhsinst} { gui_set $mhsinst "pvr" ; gui_pvr_changed $mhsinst }

proc gui_advanced_button        {mhsinst} {
  gui_set_wizard_page $mhsinst 8
  gui_set_item $mhsinst "G_GET_ADVANCED_BUTTON"
}
proc gui_wizard_button          {mhsinst} {
  gui_set_wizard_page $mhsinst $::gui_prev_wizard_page
  gui_set_item $mhsinst "G_GET_WIZARD_BUTTON"
}
proc gui_next_1_button          {mhsinst} {
  gui_set_wizard_page $mhsinst 2
  gui_set_item $mhsinst "G_GET_NEXT_1_BUTTON"
}
proc gui_back_2_button          {mhsinst} {
  gui_set_wizard_page $mhsinst 1
  gui_set_item $mhsinst "G_GET_BACK_2_BUTTON"
}
proc gui_next_2_button          {mhsinst} { 
  set area_optimized [xget_hw_parameter_value $mhsinst "C_AREA_OPTIMIZED"]
  set mmu_enabled    [xget_hw_parameter_value $mhsinst "G_GET_MMU_ENABLED"]
  set use_icache     [xget_hw_parameter_value $mhsinst "C_USE_ICACHE"]
  set use_dcache     [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]
  set debug          [xget_hw_parameter_value $mhsinst "C_DEBUG_ENABLED"]
  set use_exc        [xget_hw_parameter_value $mhsinst "G_GET_USE_EXCEPTIONS"]
  set use_mmu        [expr $mmu_enabled && ! $area_optimized]

  set page 7
  if {$use_mmu}                   {set page 6}
  if {$use_icache || $use_dcache} {set page 5}
  if {$debug}                     {set page 4}
  if {$use_exc}                   {set page 3}

  gui_set_wizard_page $mhsinst $page
  gui_set_item $mhsinst "G_GET_NEXT_2_BUTTON"
}
proc gui_back_3_button          {mhsinst} {
  gui_set_wizard_page $mhsinst 2
  gui_set_item $mhsinst "G_GET_BACK_3_BUTTON"
}
proc gui_next_3_button          {mhsinst} {
  set area_optimized [xget_hw_parameter_value $mhsinst "C_AREA_OPTIMIZED"]
  set mmu_enabled    [xget_hw_parameter_value $mhsinst "G_GET_MMU_ENABLED"]
  set use_icache     [xget_hw_parameter_value $mhsinst "C_USE_ICACHE"]
  set use_dcache     [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]
  set debug          [xget_hw_parameter_value $mhsinst "C_DEBUG_ENABLED"]
  set use_mmu        [expr $mmu_enabled && ! $area_optimized]

  set page 7
  if {$use_mmu}                   {set page 6}
  if {$use_icache || $use_dcache} {set page 5}
  if {$debug}                     {set page 4}

  gui_set_wizard_page $mhsinst $page
  gui_set_item $mhsinst "G_GET_NEXT_3_BUTTON"
}
proc gui_back_4_button          {mhsinst} {
  set use_exc [xget_hw_parameter_value $mhsinst "G_GET_USE_EXCEPTIONS"]

  set page 2
  if {$use_exc} {set page 3}

  gui_set_wizard_page $mhsinst $page
  gui_set_item $mhsinst "G_GET_BACK_4_BUTTON"
}
proc gui_next_4_button          {mhsinst} {
  set area_optimized [xget_hw_parameter_value $mhsinst "C_AREA_OPTIMIZED"]
  set mmu_enabled    [xget_hw_parameter_value $mhsinst "G_GET_MMU_ENABLED"]
  set use_icache     [xget_hw_parameter_value $mhsinst "C_USE_ICACHE"]
  set use_dcache     [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]
  set use_mmu        [expr $mmu_enabled && ! $area_optimized]

  set page 7
  if {$use_mmu}                   {set page 6}
  if {$use_icache || $use_dcache} {set page 5}

  gui_set_wizard_page $mhsinst $page
  gui_set_item $mhsinst "G_GET_NEXT_4_BUTTON"
}
proc gui_back_5_button          {mhsinst} {
  set debug   [xget_hw_parameter_value $mhsinst "C_DEBUG_ENABLED"]
  set use_exc [xget_hw_parameter_value $mhsinst "G_GET_USE_EXCEPTIONS"]

  set page 2
  if {$use_exc} {set page 3}
  if {$debug}   {set page 4}

  gui_set_wizard_page $mhsinst $page
  gui_set_item $mhsinst "G_GET_BACK_5_BUTTON"
}
proc gui_next_5_button          {mhsinst} {
  set area_optimized [xget_hw_parameter_value $mhsinst "C_AREA_OPTIMIZED"]
  set mmu_enabled    [xget_hw_parameter_value $mhsinst "G_GET_MMU_ENABLED"]
  set use_mmu        [expr $mmu_enabled && ! $area_optimized]

  set page 7
  if {$use_mmu} {set page 6}

  gui_set_wizard_page $mhsinst $page
  gui_set_item $mhsinst "G_GET_NEXT_5_BUTTON"
}
proc gui_back_6_button          {mhsinst} {
  set use_icache [xget_hw_parameter_value $mhsinst "C_USE_ICACHE"]
  set use_dcache [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]
  set debug      [xget_hw_parameter_value $mhsinst "C_DEBUG_ENABLED"]
  set use_exc    [xget_hw_parameter_value $mhsinst "G_GET_USE_EXCEPTIONS"]

  set page 2
  if {$use_exc}                   {set page 3}
  if {$debug}                     {set page 4}
  if {$use_icache || $use_dcache} {set page 5}

  gui_set_wizard_page $mhsinst $page
  gui_set_item $mhsinst "G_GET_BACK_6_BUTTON"
}
proc gui_next_6_button          {mhsinst} {
  gui_set_wizard_page $mhsinst 7
  gui_set_item $mhsinst "G_GET_NEXT_6_BUTTON"
}
proc gui_back_7_button          {mhsinst} {
  set area_optimized [xget_hw_parameter_value $mhsinst "C_AREA_OPTIMIZED"]
  set mmu_enabled    [xget_hw_parameter_value $mhsinst "G_GET_MMU_ENABLED"]
  set use_icache     [xget_hw_parameter_value $mhsinst "C_USE_ICACHE"]
  set use_dcache     [xget_hw_parameter_value $mhsinst "C_USE_DCACHE"]
  set debug          [xget_hw_parameter_value $mhsinst "C_DEBUG_ENABLED"]
  set use_exc        [xget_hw_parameter_value $mhsinst "G_GET_USE_EXCEPTIONS"]
  set use_mmu        [expr $mmu_enabled && ! $area_optimized]

  set page 2
  if {$use_exc}                   {set page 3}
  if {$debug}                     {set page 4}
  if {$use_icache || $use_dcache} {set page 5}
  if {$use_mmu}                   {set page 6}

  gui_set_wizard_page $mhsinst $page
  gui_set_item $mhsinst "G_GET_BACK_7_BUTTON"
}
proc gui_first_button           {mhsinst} {
  gui_set_wizard_page $mhsinst 1
  gui_set_item $mhsinst "G_GET_FIRST_BUTTON"
}
