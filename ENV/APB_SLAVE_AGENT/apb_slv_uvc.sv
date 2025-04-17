/////////////////////////////////////////////////////////////////
//  file name   : apb_slv_uvc.sv
//  module name : apb slvTER_UVC CLASS
//////////////////////////////////////////////////////////////////


`ifndef APB_SLV_UVC_SV
`define APB_SLV_UVC_SV
 `include "apb_env_config.sv" //TODO
class apb_slave_uvc extends uvm_agent;           //------THIS CLASS IS ALSO KNOWN AS AGENT TOP


    //-------factory registration
	`uvm_component_utils(apb_slave_uvc)

	//-------config class  handle 
	apb_slv_config s_cfg_h [];         
	
	//env config handal     //------WHY
	apb_env_config env_cfg;
	
	//------agent handal 
	apb_slv_agent s_agnt_h[];  
	
	//-------constructor 
	function new(string name = "", uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
   function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		
	    //get environment configuration 
	    if (!uvm_config_db #(apb_env_config)::get(this,"","env_cfg",env_cfg))
	      `uvm_fatal("ENV_CONFIG_GET","ENV config is not available")
	    
		s_cfg_h = new[env_cfg.no_of_agts];
		s_agnt_h = new[env_cfg.no_of_agts];
		foreach(s_cfg_h[i]) begin
		  s_cfg_h[i] = apb_slv_config::type_id::create($sformatf("s_cfg_h[%0d]",i));
		  case(i)
 		   'h0 : begin
		           s_cfg_h[i].is_active = UVM_ACTIVE;
				   s_agnt_h[i] = apb_slv_agent::type_id::create($sformatf("s_agnt_h[%0d]",i),this); 
		         end
		   'h1 : begin
		           s_cfg_h[i].is_active = UVM_PASSIVE;
				s_agnt_h[i] = apb_slv_agent::type_id::create($sformatf("s_agnt_h[%0d]",i),this); 
		        end
		  endcase
		  
		  uvm_config_db #(apb_slv_config)::set(this,"*","slv_config",s_cfg_h[i]);
		end
		
		
		
	endfunction 
	
	
endclass

`endif 
