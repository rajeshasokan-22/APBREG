`ifndef REGMODEL_SV
`define REGMODEL_SV
`include "uvm_macros.svh"
import uvm_pkg::*;


class ctrl_reg extends uvm_reg;
  rand uvm_reg_field field;
  `uvm_object_utils(ctrl_reg)

  function new(string name = "ctrl_reg");
    super.new(name, 16, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    field = uvm_reg_field::type_id::create("field");
    field.configure(this, 16, 0, "RW", 0, 0, 1, 0, 1);
  endfunction
endclass

class status_reg extends uvm_reg;
  rand uvm_reg_field ready;
  rand uvm_reg_field error;
  `uvm_object_utils(status_reg)

  function new(string name = "status_reg");
    super.new(name, 16, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    error = uvm_reg_field::type_id::create("error");
    ready = uvm_reg_field::type_id::create("ready");
    error.configure(this, 1, 1, "RO", 0, 0, 1, 0, 1);
    ready.configure(this, 1, 0, "RO", 0, 0, 1, 0, 1);
  endfunction
endclass

class cmd_reg extends uvm_reg;
  rand uvm_reg_field command;
  `uvm_object_utils(cmd_reg)

  function new(string name = "cmd_reg");
    super.new(name, 16, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    command = uvm_reg_field::type_id::create("command");
    command.configure(this, 8, 0, "WO", 0, 0, 1, 0, 1);
  endfunction
endclass

class config_reg extends uvm_reg;
  rand uvm_reg_field field;
  `uvm_object_utils(config_reg)

  function new(string name = "config_reg");
    super.new(name, 16, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    field = uvm_reg_field::type_id::create("field");
    field.configure(this, 16, 0, "RW", 0, 0, 1, 0, 1);
  endfunction

  
endclass

class apb_reg_block extends uvm_reg_block;
  `uvm_object_utils(apb_reg_block)

  rand ctrl_reg   ctrl;
  rand status_reg status;
  rand cmd_reg    cmd;
  rand config_reg config_m;

  uvm_reg_map reg_map;

  function new(string name = "apb_reg_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    // Create registers
    ctrl   = ctrl_reg::type_id::create("ctrl");
    status = status_reg::type_id::create("status");
    cmd    = cmd_reg::type_id::create("cmd");
    config_m = config_reg::type_id::create("config_m");

    ctrl.add_hdl_path_slice("ctrl_reg", 0, ctrl.get_n_bits());
    status.add_hdl_path_slice("status_reg", 0, status.get_n_bits());
    cmd.add_hdl_path_slice("cmd_reg", 0, cmd.get_n_bits());
    config_m.add_hdl_path_slice("config_reg", 0, config_m.get_n_bits());

    // Build register internals
    ctrl.build();
    status.build();
    cmd.build();
    config_m.build();

    // Configure registers
    ctrl.configure(this);
    status.configure(this);
    cmd.configure(this);
    config_m.configure(this);

    // Create and populate map (4-byte aligned addresses)
    reg_map = create_map("reg_map", 0, 4, UVM_LITTLE_ENDIAN);
    reg_map.add_reg(ctrl,   'h00, "RW");
    reg_map.add_reg(status, 'h04, "RO");
    reg_map.add_reg(cmd,    'h08, "WO");
    reg_map.add_reg(config_m, 'h0C, "RW");
    add_hdl_path("tb_top.dut");
  endfunction
endclass

`endif
