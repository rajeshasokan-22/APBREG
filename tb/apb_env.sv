`ifndef APB_ENV_SV
`define APB_ENV_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_env extends uvm_env;
    apb_agent agent;

     apb_reg_block regmodel;
     apb_adapter adapter;
    `uvm_component_utils(apb_env)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        agent = apb_agent::type_id::create("agent", this);
        regmodel = apb_reg_block::type_id::create("regmodel", this);
        regmodel.build();          
        regmodel.lock_model();
        regmodel.reg_map.set_auto_predict(1);
        $display("REGMODEL type: %s", regmodel.get_type_name());
        
    endfunction


    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      // Connect regmodel to APB sequencer using adapter
      adapter = apb_adapter::type_id::create("adapter");
      regmodel.reg_map.set_sequencer(agent.seqr, adapter);
    endfunction
endclass

`endif

