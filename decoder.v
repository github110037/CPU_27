/*====================Ports Declaration====================*/
module decoder(
 	input wire [31:0] Instruct, //address:

	output wire [4:0] rs, //data:
	output wire [4:0] rt, //data:
	output wire [4:0] rd, //data:
	output wire [15:0] imm, //data:
	output wire [25:0] instr_index, //data:
	output wire [4:0] sa, //data:

	output wire [2:0] sel_wr_con, //control:
	output wire [1:0] sel_alud1_con, //control
	output wire [1:0] sel_alud2_con, //control:
	output wire [2:0] extend_con, //control:
	output wire [2:0] bjpc_con, //control:
	output wire [6:0] brcal_con, //control:
	output wire [11:0] aluop, //control:
	output wire [2:0] sbhw_con, //control:
	output wire [1:0] sel_dm_con, //control:
	output wire [3:0] sel_wb_con, //control:
	output wire [4:0] addrexc_con, //control:地址例外选择子
    output wire [1:0]  lr_con, //control:onehot模块选择子
    output wire [4:0] lubhw_con //control:lubhw模块选择子
	);

/*====================Variable Declaration====================*/
wire [31:0] ins = Instruct; 
/*====================Function Code====================*/
//--------------------Manual Code--------------------
assign rs = ins[25:21] ;
assign rt = ins[20:16] ;
assign rd = ins[15:11] ;
assign imm = ins[15:0] ;
assign instr_index = ins[25:0] ;
assign sa = ins[10:6] ;
//--------------------Python Code--------------------
assign extend_con[0] = (!ins[31])&&ins[29]&&(!ins[28]) || ins[31]&&(!ins[29])&&(!ins[28]) || ins[31]&&(!ins[29])&&ins[28]
 || ins[31]&&ins[29]&&(!ins[28]) || ins[31]&&ins[29]&&ins[28] ;
assign extend_con[1] = (!ins[31])&&ins[29]&&ins[28] ;
assign extend_con[2] = (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26]) || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]
 || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26] || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26]) ;
assign bjpc_con[0] = (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27] ;
assign bjpc_con[1] = (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26]) || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]
 || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26] || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26]) ;
assign brcal_con[0] = (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26]) ;
assign brcal_con[1] = (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26] ;
assign brcal_con[3] = (!ins[29])&&ins[28]&&ins[27]&&ins[26] ;
assign brcal_con[4] = (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26]) ;
assign sel_wr_con[0] = (!ins[31])&&ins[29] || ins[31]&&(!ins[29]) ;
assign sel_alud2_con[1] = (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&ins[26] || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])
 || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26] || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]
 || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]
 || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26]) || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])
 || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])
 || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26]) ;
assign aluop[0] = ins[29]&&ins[28]&&ins[27]&&ins[26] ;
assign sbhw_con[0] = ins[31]&&ins[29]&&(!ins[27])&&(!ins[26]) ;
assign sbhw_con[1] = ins[31]&&ins[29]&&(!ins[27])&&ins[26] ;
assign sbhw_con[2] = ins[31]&&ins[29]&&ins[27]&&ins[26] ;
assign sel_dm_con[0] = ins[31]&&ins[29]&&(!ins[27])&&(!ins[26]) || ins[31]&&ins[29]&&(!ins[27])&&ins[26] || ins[31]&&ins[29]&&ins[27]&&ins[26] ;
assign sel_dm_con[1] = ins[31]&&ins[29]&&ins[27]&&(!ins[26]) ;
assign sel_wb_con[1] = ins[31]&&(!ins[29])&&(!ins[27])&&(!ins[26]) || ins[31]&&(!ins[29])&&(!ins[27])&&ins[26] || ins[31]&&(!ins[29])&&ins[27]&&ins[26] ;
assign sel_wb_con[2] = ins[31]&&(!ins[29])&&ins[27]&&(!ins[26]) ;
assign addrexc_con[0] = ins[31]&&(!ins[29])&&(!ins[27])&&ins[26] ;
assign addrexc_con[1] = ins[31]&&(!ins[29])&&ins[27]&&ins[26] ;
assign addrexc_con[2] = ins[31]&&ins[29]&&(!ins[27])&&ins[26] ;
assign addrexc_con[3] = ins[31]&&ins[29]&&ins[27]&&ins[26] ;
assign addrexc_con[4] = (!ins[31])&&(!ins[26]) || (!ins[31])&&ins[26] || ins[31]&&(!ins[26]) ;
assign lr_con[0] = ins[31]&&(!ins[28])&&ins[27]&&(!ins[26]) ;
assign lr_con[1] = ins[31]&&ins[28]&&ins[27] ;
assign lubhw_con[0] = ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26]) ;
assign lubhw_con[1] = ins[31]&&ins[28]&&(!ins[27])&&(!ins[26]) ;
assign lubhw_con[2] = ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26] ;
assign lubhw_con[3] = ins[31]&&ins[28]&&ins[26] ;
assign lubhw_con[4] = ins[31]&&(!ins[29])&&ins[27]&&ins[26] ;
assign bjpc_con[2] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&(!ins[1]) ;
assign brcal_con[2] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[16] ;
assign brcal_con[5] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[16]) ;
assign sel_alud1_con[1] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2]) ;
assign sel_alud2_con[0] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1] ;
assign aluop[10] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2])&&ins[1] ;
assign aluop[7] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&ins[1]&&ins[0] ;
assign aluop[3] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[1]) ;
assign aluop[2] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[1]&&(!ins[0]) ;
assign aluop[1] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[1]&&ins[0] ;
assign brcal_con[6] = (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1])
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&(!ins[1]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&ins[1]
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&(!ins[1]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&(!ins[1]) ;
assign sel_wr_con[1] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1] ;
assign sel_wr_con[2] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&(!ins[3])&&(!ins[1])&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&(!ins[3])&&(!ins[1])&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&(!ins[3])&&ins[1]&&(!ins[0])
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&(!ins[3])&&ins[1]&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&ins[3]&&(!ins[1])&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&ins[3]&&(!ins[1])&&ins[0]
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&ins[3]&&ins[1]&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&ins[3]&&ins[1]&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&(!ins[3])&&(!ins[1])&&(!ins[0])
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&(!ins[3])&&(!ins[1])&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&(!ins[3])&&ins[1]&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&(!ins[3])&&ins[1]&&ins[0]
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&ins[3]&&(!ins[1])&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&ins[3]&&(!ins[1])&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&ins[3]&&ins[1]&&(!ins[0])
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&ins[3]&&ins[1]&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&(!ins[3])&&(!ins[1])&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&(!ins[3])&&(!ins[1])&&ins[0]
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&(!ins[3])&&ins[1]&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&(!ins[3])&&ins[1]&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&ins[3]&&(!ins[1])&&(!ins[0])
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&ins[3]&&(!ins[1])&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&ins[3]&&ins[1]&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&ins[3]&&ins[1]&&ins[0]
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[20])&&ins[3]&&(!ins[1])&&ins[0] ;
assign sel_alud1_con[0] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2])
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2]
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2])
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&ins[2] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&(!ins[2]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&ins[2]
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&(!ins[2]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&ins[2] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&(!ins[2])
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&ins[2] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&(!ins[2]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&ins[2]
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2])
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2]
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&ins[2] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[3])&&(!ins[2])
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[3])&&ins[2] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&ins[3]&&(!ins[2]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&ins[3]&&ins[2]
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&(!ins[3])&&(!ins[2]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&(!ins[3])&&ins[2] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&ins[3]&&(!ins[2])
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&ins[3]&&ins[2] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2])
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2]
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2])
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&ins[2] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&(!ins[2]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&ins[2]
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&(!ins[2]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&ins[2] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&(!ins[2])
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&ins[2] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&(!ins[2]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&ins[2]
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2] || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2])
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2] || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2]
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&ins[2] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2]
 || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2]) || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2] || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2])
 || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2] || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2]) || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2]
 || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2]) || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&ins[2] || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&(!ins[2])
 || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&ins[2] || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&(!ins[2]) || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&ins[2]
 || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&(!ins[2]) || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&ins[2] || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&(!ins[2])
 || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&ins[2] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&(!ins[2]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&ins[2]
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&(!ins[2]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&ins[2] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&(!ins[2])
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&ins[2] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&(!ins[2]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&ins[2]
 || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[3])&&(!ins[2]) || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[3])&&ins[2] || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&(!ins[5])&&ins[3]&&(!ins[2])
 || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&(!ins[5])&&ins[3]&&ins[2] || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&ins[5]&&(!ins[3])&&(!ins[2]) || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&ins[5]&&(!ins[3])&&ins[2]
 || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&ins[5]&&ins[3]&&(!ins[2]) || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&ins[5]&&ins[3]&&ins[2] || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2])
 || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2] || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2]) || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2]
 || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2]) || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2] || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2])
 || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&ins[2] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2])
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2]
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2])
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&ins[2] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2]
 || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2])
 || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&ins[2]
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&ins[2] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&(!ins[2])
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&ins[2] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&ins[2]
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&ins[2] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&(!ins[2])
 || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&ins[2] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&(!ins[2]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&ins[2]
 || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&(!ins[2]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&ins[2] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&(!ins[2])
 || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&ins[2] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[3])&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[3])&&ins[2]
 || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&ins[3]&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&ins[3]&&ins[2] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&(!ins[3])&&(!ins[2])
 || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&(!ins[3])&&ins[2] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&ins[3]&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&ins[3]&&ins[2]
 || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2])
 || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2]
 || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&ins[2] || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2])
 || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2] || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2]) || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2]
 || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2]) || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2] || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2])
 || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&ins[2] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2]
 || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2])
 || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[3]&&ins[2]
 || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&(!ins[2]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[3])&&ins[2] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&(!ins[2])
 || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[3]&&ins[2] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&(!ins[2]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[3])&&ins[2]
 || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&(!ins[2]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[3]&&ins[2] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[3])&&(!ins[2])
 || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[3])&&ins[2] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&ins[3]&&(!ins[2]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&ins[3]&&ins[2]
 || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&(!ins[3])&&(!ins[2]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&(!ins[3])&&ins[2] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&ins[3]&&(!ins[2])
 || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&ins[3]&&ins[2] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2]
 || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2])
 || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&ins[2]
 || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&(!ins[2]) || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[3])&&ins[2] || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&(!ins[2])
 || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[3]&&ins[2] || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&(!ins[2]) || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[3])&&ins[2]
 || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&(!ins[2]) || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[3]&&ins[2] ;
assign aluop[11] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1]
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1])
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&ins[1]
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[2])&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[2])&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[2]&&(!ins[1])
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[2]&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[2])&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[2])&&ins[1]
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[2]&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[2]&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1])
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1]
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1])
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1]
 || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1])
 || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&ins[1]
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[2])&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[2])&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[2]&&(!ins[1])
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[2]&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[2])&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[2])&&ins[1]
 || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[2]&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[2]&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[2])&&(!ins[1])
 || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[2])&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[2]&&(!ins[1]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[2]&&ins[1]
 || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[2])&&(!ins[1]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[2])&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&ins[2]&&(!ins[1])
 || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[5]&&ins[2]&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[2])&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[2])&&ins[1]
 || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&ins[2]&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&ins[2]&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&(!ins[2])&&(!ins[1])
 || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&(!ins[2])&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&ins[2]&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&ins[2]&&ins[1]
 || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1])
 || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1]
 || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1])
 || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1]) || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1]
 || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1]) || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1])
 || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1]
 || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1])
 || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&ins[1]
 || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[2])&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&(!ins[2])&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[2]&&(!ins[1])
 || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[5])&&ins[2]&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[2])&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&(!ins[2])&&ins[1]
 || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[2]&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[5]&&ins[2]&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[2])&&(!ins[1])
 || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&(!ins[2])&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&ins[2]&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[5])&&ins[2]&&ins[1]
 || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&(!ins[2])&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&(!ins[2])&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&ins[2]&&(!ins[1])
 || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[5]&&ins[2]&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1]
 || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1])
 || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&ins[1]
 || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1]) || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1] || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1])
 || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1] || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1]) || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1]
 || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1]) || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&ins[1] ;
assign aluop[9] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1])&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1])&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1])&&ins[0]
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1]&&ins[0] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1])&&(!ins[0])
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1])&&ins[0] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1]&&ins[0]
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1])&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1])&&ins[0] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1]&&(!ins[0])
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1]&&ins[0] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1])&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1])&&ins[0]
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&ins[1]&&ins[0] ;
assign aluop[8] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[2]&&(!ins[1])&&ins[0] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[2])&&(!ins[1])&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[2])&&(!ins[1])&&ins[0]
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[2])&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[2])&&ins[1]&&ins[0] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[2]&&(!ins[1])&&(!ins[0])
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[2]&&(!ins[1])&&ins[0] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[2]&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[2]&&ins[1]&&ins[0] ;
assign aluop[6] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[5]&&ins[2]&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1])&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&(!ins[1])&&ins[0]
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&(!ins[2])&&ins[1]&&ins[0] || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1])&&(!ins[0])
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&(!ins[1])&&ins[0] || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[5])&&ins[2]&&ins[1]&&ins[0]
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1])&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&(!ins[1])&&ins[0] || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1]&&(!ins[0])
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&(!ins[2])&&ins[1]&&ins[0] || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1])&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&(!ins[1])&&ins[0]
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[5]&&ins[2]&&ins[1]&&ins[0] ;
assign aluop[5] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1])&&(!ins[0]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1])&&ins[0]
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1]&&ins[0] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1])&&(!ins[0])
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1])&&ins[0] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&ins[1]&&ins[0] ;
assign aluop[4] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1]&&ins[0] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&(!ins[1])&&(!ins[0]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&(!ins[1])&&ins[0]
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&ins[1]&&ins[0] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&(!ins[1])&&(!ins[0])
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&(!ins[1])&&ins[0] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&ins[1]&&(!ins[0]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&ins[1]&&ins[0] ;
assign sel_wb_con[0] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1]
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&(!ins[1])
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[3])&&ins[1]
 || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[3]&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[3]&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1])
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&ins[1]
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&(!ins[1])
 || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&ins[1] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1]
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[3]&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[3])&&(!ins[1])
 || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[3])&&ins[1] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[3]&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[3]&&ins[1]
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1])
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[3]&&ins[1] || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&ins[26]&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&ins[26]&&(!ins[3])&&ins[1]
 || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&ins[26]&&ins[3]&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&ins[26]&&ins[3]&&ins[1] ;
assign sel_wb_con[3] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&(!ins[3])&&(!ins[1])&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&(!ins[3])&&(!ins[1])&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&(!ins[3])&&ins[1]&&(!ins[0])
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&(!ins[3])&&ins[1]&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&ins[3]&&(!ins[1])&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&ins[3]&&(!ins[1])&&ins[0]
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&ins[3]&&ins[1]&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[20]&&ins[3]&&ins[1]&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&(!ins[3])&&(!ins[1])&&(!ins[0])
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&(!ins[3])&&(!ins[1])&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&(!ins[3])&&ins[1]&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&(!ins[3])&&ins[1]&&ins[0]
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&ins[3]&&(!ins[1])&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&ins[3]&&(!ins[1])&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&ins[3]&&ins[1]&&(!ins[0])
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[20])&&ins[3]&&ins[1]&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&(!ins[3])&&(!ins[1])&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&(!ins[3])&&(!ins[1])&&ins[0]
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&(!ins[3])&&ins[1]&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&(!ins[3])&&ins[1]&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&ins[3]&&(!ins[1])&&(!ins[0])
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&ins[3]&&(!ins[1])&&ins[0] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&ins[3]&&ins[1]&&(!ins[0]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[20]&&ins[3]&&ins[1]&&ins[0]
 || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[20])&&ins[3]&&(!ins[1])&&ins[0] ;
// assign bjaddrexc_con[0] = (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[3]&&(!ins[1])
//  || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1] || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[3])&&(!ins[1]) || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[3])&&ins[1]
//  || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[3]&&(!ins[1]) || (!ins[31])&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[3]&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[3])&&(!ins[1])
//  || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[3])&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[3]&&(!ins[1]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[3]&&ins[1]
//  || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&(!ins[3])&&(!ins[1]) || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&(!ins[3])&&ins[1] || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&ins[3]&&(!ins[1])
//  || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&ins[26]&&ins[3]&&ins[1] || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1]
//  || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1]) || (!ins[31])&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[3]&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1])
//  || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&ins[1]
//  || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&(!ins[1]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&(!ins[1])
//  || (!ins[31])&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&(!ins[1]) ;
// assign bjaddrexc_con[1] = (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1]
//  || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&(!ins[1])
//  || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[3])&&ins[1]
//  || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[3]&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[3]&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1])
//  || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&ins[1]
//  || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&ins[1] || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&(!ins[1])
//  || (!ins[31])&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&ins[1] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1]
//  || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[3]&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[3])&&(!ins[1])
//  || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[3])&&ins[1] || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[3]&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&(!ins[27])&&ins[26]&&ins[3]&&ins[1]
//  || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1] || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1])
//  || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[3]&&ins[1] || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&ins[26]&&(!ins[3])&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&ins[26]&&(!ins[3])&&ins[1]
//  || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&ins[26]&&ins[3]&&(!ins[1]) || (!ins[31])&&ins[29]&&ins[28]&&ins[27]&&ins[26]&&ins[3]&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1])
//  || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1]
//  || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[3]&&(!ins[1])
//  || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[3])&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[3])&&ins[1]
//  || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[3]&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[3]&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[3])&&(!ins[1])
//  || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&(!ins[3])&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[3]&&(!ins[1]) || ins[31]&&(!ins[29])&&ins[28]&&(!ins[27])&&ins[26]&&ins[3]&&ins[1]
//  || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&(!ins[1])
//  || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&ins[1] || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1]
//  || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1]) || ins[31]&&(!ins[29])&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1])
//  || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1] || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1]) || ins[31]&&(!ins[29])&&ins[28]&&ins[27]&&(!ins[26])&&ins[3]&&ins[1]
//  || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&(!ins[3])&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&(!ins[1])
//  || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&(!ins[26])&&ins[3]&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[3])&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&(!ins[3])&&ins[1]
//  || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[3]&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&(!ins[27])&&ins[26]&&ins[3]&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&(!ins[1])
//  || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&(!ins[3])&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&ins[26]&&ins[3]&&ins[1]
//  || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1]) || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1] || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1])
//  || ins[31]&&ins[29]&&(!ins[28])&&ins[27]&&(!ins[26])&&ins[3]&&ins[1] || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[3])&&(!ins[1]) || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&(!ins[3])&&ins[1]
//  || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[3]&&(!ins[1]) || ins[31]&&ins[29]&&ins[28]&&ins[27]&&(!ins[26])&&ins[3]&&ins[1] ;

endmodule