from python_simulation.videocard_modules.instructions import *

class Disassembler:
    def __init__(self):
        pass

    """
    returns dictionary with given keys:
        func, suf, dest, op1, op2, type, recipient
    
    func - function that represents instruction
    recipient - 'core' if instruction for cores, else 'proc'
    
    type: core_alu
        func - any alu command. 
        suf - suffixes for instruction  ex: 'gt'
        dest - destination register     [reg0-3]
        op1 - first operand             [reg0-3]    Note: if this is not/inc/dec/cmp command then op1 and op2 have reg0
        op2 - second operand            [reg0-3]
    
    type: proc_alu
        func - any alu command.
        suf - suffixes for instruction  ex: 'gt'
        dest - destination register     [reg0-7]
        op1 - first operand             [reg0-7]    Note: if this is not/inc/dec command then op1 has reg0
        op2 - None
    
    
    type: core_mem_suffix
        func - mov_/ store_/ load_
        suf - suffixes for instruction  ex: 'gt'
        dest - first register that will have copied value of second if mov or value to load/store
        op1 - second register that will have value to move if mov, or address for storing/loading
        op2 - None
        
    type: core_mem_num
        func - movl_ / movh_
        suf - None
        dest - register that will hold number after execution
        op1 - number to store in dest
        op2 - None
    
    type: core_mem_flags
        func - movf_
        suf - None
        dest - register for storing flags
        op1 - None
        op2 - None
        
    type: chmod_chbuf
        func - chmod_/ chbuf_
        suf - None
        dest - None
        op1 - None
        op2 - None
        
    type: proc_mem_suffix
        func - movi_/ storei_/ loadi_
        suf - suffixes for instruction  ex: 'gt'
        dest - first register that will have copied value of second if mov or value to load/store
        op1 - second register that will have value to move if mov, or address for storing/loading
        op2 - None
    
    type: proc_mem_num
        func - movli_/ movhi_
        suf - None
        dest - register that will hold number after execution
        op1 - number to store in dest
        op2 - None
    
    type: proc_mem_flags
        func - movfi_
        suf - None
        dest - register for storing flags
        op1 - None
        op2 - None
    
    type: jumps
        func - je_/ jne_/ jgt_/ jge_/ jlt_/ jle_
        suf - None
        dest - register with address
        op1 - None
        op2 - None
        
        
    """
    def decode_instruction(self, instruction):
        result = {}
        # core alu
        if instruction[0:2] == "11":
            result["func"] = self.core_alu_inst[instruction[2:6]]      # 4 bits on alu instruction type
            result["suf"] = self.suffixes[instruction[6:10]]            # 4 bits on sufixxes
            result["dest"] = self.core_registers[instruction[10:12]]    # 2 bits on destination register
            result["op1"] = self.core_registers[instruction[12:14]]     # 2 bits on first operand
            result["op2"] = self.core_registers[instruction[14:16]]     # 2 bits on second operand
            result["recipient"] = "core"
            result["type"] = "core_alu"

        # processor alu
        elif instruction[0:2] == "01":
            result["func"] = self.proc_alu_inst[instruction[2:6]]           # 4 bits on alu instruction type
            result["suf"] = self.suffixes[instruction[6:10]]                # 4 bits on sufixxes
            result["dest"] = self.proc_registers[instruction[10:13]]        # 3 bits on destination register
            result["op1"] = self.proc_registers[instruction[13:16]]         # 3 bits on operand
            result["op2"] = None
            result["recipient"] = "proc"
            result["type"] = "proc_alu"

        # core memory
        elif instruction[0:2] == "10":
            result["func"] = self.core_mem_inst[instruction[2:7]]          # 5 bits on mem instrcution type
            func = self.core_mem_inst_string[instruction[2:7]]
            if func in self.mem_suffix_commands:
                result["suf"] = self.suffixes0[instruction[7:10]] if func[-1] == "0" \
                    else self.suffixes1[instruction[7:10]]                  # 3 bits on suffix (why 3 read docum)
                result["dest"] = self.core_registers[instruction[10:12]]    # 2 bits on first register
                result["op1"] = self.core_registers[instruction[12:14]]     # 2 bits on second register
                result["op2"] = None                                        # 2 unused bits
                result["type"] = "core_mem_suffix"
            elif func in self.mem_number_commands or func in self.mem_move_flags:
                result["suf"] = None
                result["dest"] = "reg" + func[-1]                           # 0 bits on dst register
                result["op1"] = int(instruction[7:15], 2) if func in self.mem_number_commands \
                    else None # 8 bits on number
                result["op2"] = None
                result["type"] = "core_mem_num" if func in self.mem_number_commands \
                    else "core_mem_flags"
            # chmod or chbuf
            else:
                result["suf"] = None
                result["dest"] = None
                result["op1"] = None
                result["op2"] = None
                result["type"] = "chmod_chbuf"
            result["recipient"] = "core"

        # processor mem
        elif instruction[0:2] == "00":
            result["func"] = self.proc_mem_inst[instruction[2:7]]       # 5 bits on mem instrcution type
            func = self.proc_mem_inst_string[instruction[2:7]]
            if func in self.mem_suffix_commands:
                result["suf"] = self.suffixes0[instruction[7:10]] if func[-1] == "0" \
                    else self.suffixes1[instruction[7:10]]              # 3 bits on suffix (why 3 read docum)
                result["dest"] = self.proc_registers[instruction[10:13]]# 3 bits on first register
                result["op1"] = self.proc_registers[instruction[13:16]] # 3 bits on second register
                result["op2"] = None  # 2 unused bits
                result["type"] = "proc_mem_suffix"
            elif func in self.mem_number_commands or func in self.mem_move_flags:
                result["suf"] = None
                result["dest"] = "reg" + func[-2:-1]                    # 0 bits on dst register
                result["op1"] = int(instruction[7:15], 2) if func in self.mem_number_commands \
                    else None  # 8 bits on number
                result["op2"] = None
                result["type"] = "proc_mem_num" if func in self.mem_number_commands \
                    else "proc_mem_flags"
            # jumps
            else:
                result["suf"] = None
                result["dest"] = self.proc_registers[instruction[10:13]] # register with address
                result["op1"] = None
                result["op2"] = None
                result["type"] = "jumps"
            result["recipient"] = "proc"

        return result

    core_alu_inst = {
        '0000': add_,
        '0001': addc_,
        '0010': sub_,
        '0011': subc_,
        '0100': mul_,
        '0101': mulc_,
        '0110': and_,
        '0111': or_,
        '1000': xor_,
        '1001': lsh_,
        '1010': rsh_,
        '1011': not_,
        '1100': cmp_,
        '1101': inc_,
        '1110': dec_
    }

    core_mem_inst = {
        '00000': load_,
        '00001': load_,
        '00010': store_,
        '00011': store_,
        '00100': mov_,
        '00101': mov_,
        '00110': movh_,
        '00111': movh_,
        '01000': movh_,
        '01001': movh_,
        '01010': movl_,
        '01011': movl_,
        '01100': movl_,
        '01101': movl_,
        '01110': movf_,
        '01111': movf_,
        '10000': movf_,
        '10001': movf_,
        '10010': chmod_,
        '10011': chbuf_
    }

    core_mem_inst_string = {
        '00000': 'load0',
        '00001': 'load1',
        '00010': 'store0',
        '00011': 'store1',
        '00100': 'mov0',
        '00101': 'mov1',
        '00110': 'movh0',
        '00111': 'movh1',
        '01000': 'movh2',
        '01001': 'movh3',
        '01010': 'movl0',
        '01011': 'movl1',
        '01100': 'movl2',
        '01101': 'movl3',
        '01110': 'movf0',
        '01111': 'movf1',
        '10000': 'movf2',
        '10001': 'movf3',
        '10010': 'chmod',
        '10011': 'chbuf'
    }

    proc_alu_inst = {
        '0000': addi_,
        '0001': addci_,
        '0010': subi_,
        '0011': subci_,
        '0100': muli_,
        '0101': mulci_,
        '0110': andi_,
        '0111': ori_,
        '1000': xori_,
        '1001': lshi_,
        '1010': rshi_,
        '1011': noti_,
        '1100': cmpi_,
        '1101': inci_,
        '1110': deci_
    }

    proc_mem_inst_string = {
        '00000': 'loadi0',
        '00001': 'storei0',
        '00010': 'movi0',
        '00011': 'loadi1',
        '00100': 'storei1',
        '00101': 'movi1',
        '00110': 'movh0i',
        '00111': 'movh1i',
        '01000': 'movh2i',
        '01001': 'movh3i',
        '01010': 'movh4i',
        '01011': 'movh5i',
        '01100': 'movl0i',
        '01101': 'movl1i',
        '01110': 'movl2i',
        '01111': 'movl3i',
        '10000': 'movl4i',
        '10001': 'movl5i',
        '10010': 'movf0i',
        '10011': 'movf1i',
        '10100': 'movf2i',
        '10101': 'movf3i',
        '10110': 'movf4i',
        '10111': 'movf5i',
        '11000': 'je',
        '11001': 'jne',
        '11010': 'jgt',
        '11011': 'jge',
        '11100': 'jlt',
        '11101': 'jle'
    }

    proc_mem_inst = {
        '00000': loadi_,
        '00001': storei_,
        '00010': movi_,
        '00011': loadi_,
        '00100': storei_,
        '00101': movi_,
        '00110': movhi_,
        '00111': movhi_,
        '01000': movhi_,
        '01001': movhi_,
        '01010': movhi_,
        '01011': movhi_,
        '01100': movli_,
        '01101': movli_,
        '01110': movli_,
        '01111': movli_,
        '10000': movli_,
        '10001': movli_,
        '10010': movfi_,
        '10011': movfi_,
        '10100': movfi_,
        '10101': movfi_,
        '10110': movfi_,
        '10111': movfi_,
        '11000': je_,
        '11001': jne_,
        '11010': jgt_,
        '11011': jge_,
        '11100': jlt_,
        '11101': jle_
    }

    suffixes = {
        '0001': 'ne',
        '0010': 'gt',
        '0011': 'lt',
        '0100': 'ge',
        '0101': 'le',
        '0110': 'cs',
        '0111': 'cc',
        '1000': 'mi',
        '1001': 'pl',
        '1010': 'al',
        '1011': 'nv',
        '1100': 'vs',
        '1101': 'vc',
        '1110': 'hi',
        '1111': 'ls'
    }

    suffixes0 = {
        '001': 'ne',
        '010': 'gt',
        '011': 'lt',
        '100': 'ge',
        '101': 'le',
        '110': 'cs',
        '111': 'cc',
    }

    suffixes1 = {
        '000': 'mi',
        '001': 'pl',
        '010': 'al',
        '011': 'nv',
        '100': 'vs',
        '101': 'vc',
        '110': 'hi',
        '111': 'ls'
    }

    core_registers = {
        '00': 'reg0',
        '01': 'reg1',
        '10': 'reg2',
        '11': 'reg3'
    }

    proc_registers = {
        '000': 'reg0',
        '001': 'reg1',
        '010': 'reg2',
        '011': 'reg3',
        '100': 'reg4',
        '101': 'reg5',
        '110': 'reg6',
        '111': 'reg7'
    }

    mem_suffix_commands = [
        "mov0", "mov1", "load0", "load1", "store0", "store1",
        "movi0", "movi1", "loadi0", "loadi1", "storei0", "storei1"
    ]

    mem_number_commands = [
        'movh0', 'movh1', 'movh2', 'movh3',
        'movl0', 'movl1', 'movl2', 'movl3',
        'movh0i', 'movh1i', 'movh2i', 'movh3i', 'movh4i', 'movh5i',
        'movl0i', 'movl1i', 'movl2i', 'movl3i', 'movl4i', 'movl5i',
    ]

    mem_move_flags = [
        'movf0', 'movf1', 'movf2', 'movf3',
        'movf0i', 'movf1i', 'movf2i', 'movf3i''movf4i', 'movf4i',
    ]
