`ifndef APB_ADAPTER_SV
`define APB_ADAPTER_SV

class apb_adapter extends uvm_reg_adapter;
  `uvm_object_utils(apb_adapter)

  function new(string name = "apb_adapter");
    super.new(name);
    supports_byte_enable = 0;
    provides_responses   = 1;
  endfunction

  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    apb_txn tx = apb_txn::type_id::create("tx");
    tx.addr  = rw.addr;
    tx.write = (rw.kind == UVM_WRITE);
    tx.data  = rw.data;
    return tx;
  endfunction

  virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    apb_txn tx;
    if (!$cast(tx, bus_item)) `uvm_fatal("ADAPT", "Wrong type")
    rw.kind   = tx.write ? UVM_WRITE : UVM_READ;
    rw.addr   = tx.addr;
    rw.data   = tx.rdata;
    rw.status = UVM_IS_OK;
  endfunction
endclass

`endif
