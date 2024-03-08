module tb_DES();
	reg [64:1] message;
	reg [64:1] key;
    reg CLK;
	wire [64:1] ciphertext;

	DES dut1(message, key, CLK, ciphertext);

    always #5 CLK = ~CLK;
	
	initial begin

        CLK = 0;
		message <=  64'h02468aceeca86420;
		key <= 64'h0F1571c947d9e859;
		#10
		message <= 64'h8787878787878787;
		#10
        message <= 64'h8787878787833787;
        #10
        message <= 64'h1;
        #10
        message <= 64'h1111878787878787;
        #10
        message <= 64'h8787878787811111;
        #10
        message <= 64'h8787878000878700;
        #10
        message <= 64'h1231908130947012;
        #10
        message <= 64'h1020120120121212;
        #10
        message <= 64'h8787878787878787;
        #10
        message <= 64'h8787878787878787;
        #10
        message <= 64'h878dfdfdf8787;
        #10
        message <= 64'h8787878787878787;
        #10
        message <= 64'h878787df8787;

           #1000 
		$finish;

	end


endmodule