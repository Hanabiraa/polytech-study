`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2022 10:10:23 PM
// Design Name: 
// Module Name: new
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module new(
    input clk,
    input rst,
    output [7:0] led
    );
    reg [25:0]count;
    wire rst_but =~ rst;
    always @(posedge clk or posedge rst_but) begin
    if (rst_but)
    count <= 1'b0;
    else
    count <= count + 1'b1;
    end
    assign led[7:0] = count[25:19];
endmodule
