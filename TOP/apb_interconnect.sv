module apb_interconnect #(parameter NUM_SLAVES = 4)(
  input  logic [31:0] PADDR,
  input  logic        PWRITE,
  input  logic        PENABLE,
  input  logic [31:0] PWDATA,
  output logic [NUM_SLAVES-1:0] PSLE,
  input  bit [NUM_SLAVES-1:0] PREADY_SLV,
  input  bit [NUM_SLAVES-1:0] PSLVERR_SLV,
  input  bit [NUM_SLAVES-1:0][31:0] PRDATA_SLV,
  output logic [31:0] PRDATA,
  output logic PSLVERR,
  output logic PREADY
);

  logic [1:0] sel;

  always_comb begin
    
    sel = PADDR[31:30];

    // Default: all slaves de-selected
    PSLE = '0;

    // Select only one slave based on address
    PSLE[sel] = 1'b1;

    // Get data from selected slave
    if(!PWRITE) begin
      PRDATA = PRDATA_SLV[sel];
    end
    PSLVERR = PSLVERR_SLV[sel];
    PREADY = PREADY_SLV[sel];
  end

endmodule

