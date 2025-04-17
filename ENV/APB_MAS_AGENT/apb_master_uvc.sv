/////////////////////////////////////////////////////////////////
//  file name   : apb_master_uvc.sv
//  module name : apb MASTER_UVC CLASS
//////////////////////////////////////////////////////////////////


`ifndef APB_MAS_UVC_SV
`define APB_MAS_UVC_SV
 `include "apb_env_config.sv" //TODO
class apb_masterter_uvc extends uvm_agent;           //------THIS CLASS IS ALSO KNOWN AS AGENT TOP


    //-------factory registration
	`uvm_component_utils(apb_masterter_uvc)

	//-------config class  handle 
	apb_master_config m_cfg_h [];         
	
	//env config handal     //------WHY
	apb_env_config env_cfg;
	
	//------agent handal 
	apb_master_agent m_agnt_h[];  
	
	//-------constructor 
	function new(string name = "", uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
   function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		
	    //get environment configuration 
	    if (!uvm_config_db #(apb_env_config)::get(this,"","env_cfg",env_cfg))
	      `uvm_fatal("ENV_CONFIG_GET","ENV config is not available")
	    
		m_cfg_h = new[env_cfg.no_of_agts];
		m_agnt_h = new[env_cfg.no_of_agts];
		foreach(m_cfg_h[i]) begin
		  m_cfg_h[i] = apb_master_config::type_id::create($sformatf("m_cfg_h[%0d]",i));
		  begin
		           m_cfg_h[i].is_active = UVM_ACTIVE;
				   m_agnt_h[i] = apb_master_agent::type_id::create($sformatf("m_agnt_h[%0d]",i),this); 
		         end
		   // 'h1 : begin
		           // m_cfg_h[i].is_active = UVM_PASSIVE;
				// m_agnt_h[i] = apb_master_agent::type_id::create($sformatf("m_agnt_h[%0d]",i),this); 
		        // end
		  // endcase
		  
		  uvm_config_db #(apb_master_config)::set(this,"*","master_config",m_cfg_h[i]);
		end
		
		
		
	endfunction 
	
	
endclass

`endif 
