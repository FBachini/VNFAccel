# VNFCAccel

The expected benefits of Network Function Virtualization (NFV), i.e., flexibility and efficiency, require platforms able to instantiate Virtualized Network Functions (VNFs), replacing traditional dedicated middleboxes. However, to fulfill performance requirements, especially for compute-intensive functions, dedicated hardware acceleration may be required and, to provide the expected flexibility, hardware accelerators must be able to support different VNFs. Thus, reconfigurable devices such as Field-Programmable Gate Arrays (FPGAs) have received attention due to their ability to provide both properties. Not all VNFs, however, require or are even suitable for hardware acceleration and, therefore, heterogeneous platforms composed of FPGAs and General Purpose Processors (GPPs) can be used. Even for a single VNF, distinct VNF Components (VNFCs) may have different demands and restrictions, meaning that different hardware substrates may be more suitable for their implementation. 
We propose VNFAccel, a platform to manage the execution of VNFCs in a heterogeneous infrastructure, evaluating the effectiveness of FPGA as an accelerator device for VNFs. 
