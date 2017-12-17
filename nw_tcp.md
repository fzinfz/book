
<!-- TOC -->

- [Data](#data)
- [Source port (16 bits)](#source-port-16-bits)
- [Destination port (16 bits)](#destination-port-16-bits)
- [Sequence number (32 bits)](#sequence-number-32-bits)
- [Acknowledgment number (32 bits)](#acknowledgment-number-32-bits)
- [Data offset (4 bits)](#data-offset-4-bits)
- [Reserved (3 bits)](#reserved-3-bits)
- [Flags (9 bits) (aka Control bits)](#flags-9-bits-aka-control-bits)
    - [NS(1 bit): ECN-nonce - concealment protection](#ns1-bit-ecn-nonce---concealment-protection)
    - [CWR(1 bit): Congestion Window Reduced (CWR)](#cwr1-bit-congestion-window-reduced-cwr)
    - [ECE (1 bit): ECN-Echo](#ece-1-bit-ecn-echo)
    - [URG (1 bit)](#urg-1-bit)
    - [ACK (1 bit)](#ack-1-bit)
    - [PSH (1 bit): Push function](#psh-1-bit-push-function)
    - [RST (1 bit): Reset the connection](#rst-1-bit-reset-the-connection)
    - [SYN (1 bit): Synchronize sequence numbers](#syn-1-bit-synchronize-sequence-numbers)
    - [FIN (1 bit): Last packet from sender](#fin-1-bit-last-packet-from-sender)
- [Window size (16 bits)](#window-size-16-bits)
- [Checksum (16 bits)](#checksum-16-bits)
- [Urgent pointer (16 bits)](#urgent-pointer-16-bits)
- [Options (Variable 0–320 bits, divisible by 32)](#options-variable-0320-bits-divisible-by-32)
- [Padding](#padding)
- [Protocol Operation](#protocol-operation)
- [States](#states)
    - [LISTEN](#listen)
    - [SYN-SENT](#syn-sent)
    - [SYN-RECEIVED](#syn-received)
    - [ESTABLISHED](#established)
    - [FIN-WAIT-1](#fin-wait-1)
    - [FIN-WAIT-2](#fin-wait-2)
    - [CLOSE-WAIT](#close-wait)
    - [CLOSING](#closing)
    - [LAST-ACK](#last-ack)
    - [TIME-WAIT](#time-wait)
    - [CLOSED](#closed)
- [Connection establishment - full-duplex](#connection-establishment---full-duplex)
    - [SYN](#syn)
    - [SYN-ACK](#syn-ack)
    - [ACK](#ack)
- [Connection termination](#connection-termination)
- [Flow control](#flow-control)
- [Window scaling](#window-scaling)

<!-- /TOC -->

# Data
https://en.wikipedia.org/wiki/Transmission_Control_Protocol

# Source port (16 bits)

# Destination port (16 bits)

# Sequence number (32 bits)
- If the SYN flag is set (1), then this is the initial sequence number. The sequence number of the actual first data byte and the acknowledged number in the corresponding ACK are then this sequence number plus 1.
- If the SYN flag is clear (0), then this is the accumulated sequence number of the first data byte of this segment for the current session.

# Acknowledgment number (32 bits)
If the ACK flag is set then the value of this field is the next sequence number that the sender is expecting. This acknowledges receipt of all prior bytes (if any). The first ACK sent by each end acknowledges the other end's initial sequence number itself, but no data.

# Data offset (4 bits)
Specifies the size of the TCP header in 32-bit words.  
The minimum size header is 5 words and the maximum is 15 words thus giving the minimum size of 20 bytes and maximum of 60 bytes, allowing for up to 40 bytes of options in the header. （？）  
also the offset from the start of the TCP segment to the actual data.

# Reserved (3 bits)
For future use and should be set to zero.

# Flags (9 bits) (aka Control bits)
## NS(1 bit): ECN-nonce - concealment protection
https://tools.ietf.org/html/rfc3540  
Robust Explicit Congestion Notification (ECN) Signaling with Nonces

   The ECN-nonce enables the sender to verify the correct behavior of
   the ECN receiver and that there is no other interference that
   conceals marked (or dropped) packets in the signaling path.

## CWR(1 bit): Congestion Window Reduced (CWR)
set by the sending host to indicate that it received a TCP segment with the ECE flag set and had responded in congestion control mechanism (added to header by RFC 3168).

## ECE (1 bit): ECN-Echo
has a dual role:
- If the SYN flag is set (1), that the TCP peer is ECN capable.
- If the SYN flag is clear (0), that a packet with Congestion Experienced flag set (ECN=11) in IP header was received during normal transmission (added to header by RFC 3168). This serves as an indication of network congestion (or impending congestion) to the TCP sender.

## URG (1 bit)
indicates that the Urgent pointer field is significant

## ACK (1 bit)
indicates that the Acknowledgment field is significant.  
*All packets after the initial SYN packet sent by the client should have this flag set.*

## PSH (1 bit): Push function
Asks to push the buffered data to the receiving application.

## RST (1 bit): Reset the connection

## SYN (1 bit): Synchronize sequence numbers
Only the first packet sent from each end should have this flag set.   
Some other flags and fields change meaning based on this flag, and some are only valid for when it is set, and others when it is clear.

## FIN (1 bit): Last packet from sender

# Window size (16 bits)
 the number of window size units(by default, bytes) (beyond the segment identified by the sequence number in the acknowledgment field) that *the sender of this segment is currently willing to receive* (see Flow control and Window Scaling).

# Checksum (16 bits)
    error-checking of the header, the Payload and a Pseudo-Header.  
        The Pseudo-Header consist of：
            the Source IP Address, 
            the Destination IP Address, 
            the protocol number for the TCP-Protocol (0x0006) 
            the length of the TCP-Headers including Payload (in Bytes)

# Urgent pointer (16 bits)
if the [URG](#urg-1-bit) flag is set, then this 16-bit field is an offset from the sequence number indicating the last urgent data byte.

# Options (Variable 0–320 bits, divisible by 32)
if data offset > 5. Padded at the end with "0" bytes if necessary.

# Padding
Zeros. ensure that the TCP header ends and data begins on a 32 bit boundary.

# Protocol Operation
three phases. 
Connections must be properly established in a multi-step handshake process (connection establishment) before entering the data transfer phase.   
After data transmission is completed, the connection termination closes established virtual circuits and releases all allocated resources.

A TCP connection is managed by an operating system through socket.

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Tcp_state_diagram_fixed_new.svg/1592px-Tcp_state_diagram_fixed_new.svg.png)

http://www.medianet.kent.edu/techreports/TR2005-07-22-tcp-EFSM.pdf

# States
## LISTEN
(server)

## SYN-SENT
(client) waiting for a matching connection request after having sent a connection request.

## SYN-RECEIVED
(server) represents waiting for a confirming connection request acknowledgment after having both received and sent a connection request.

## ESTABLISHED
(both server and client) normal state for the data transfer phase of the connection.

## FIN-WAIT-1
(both server and client) represents waiting for a connection termination request from the remote TCP, or an acknowledgment of the connection termination request previously sent.

## FIN-WAIT-2
(both server and client) represents waiting for a connection termination request from the remote TCP.

## CLOSE-WAIT
(both server and client) represents waiting for a connection termination request from the local user.

## CLOSING
(both server and client) represents waiting for a connection termination request acknowledgment from the remote TCP.

## LAST-ACK
(both server and client) represents waiting for an acknowledgment of the connection termination request previously sent to the remote TCP (which includes an acknowledgment of its connection termination request).

## TIME-WAIT
(either server or client) represents waiting for enough time to pass to be sure the remote TCP received the acknowledgment of its connection termination request. [According to RFC 793 a connection can stay in TIME-WAIT for a maximum of four minutes known as two MSL (maximum segment lifetime).]

## CLOSED
(both server and client) represents no connection state at all.

# Connection establishment - full-duplex
three-way (or 3-step) handshake:

## SYN
client sending a SYN to the server.  
client sets the segment's sequence number to a random value A.

## SYN-ACK
server replies with a SYN-ACK.  
acknowledgment number: A+N  
sequence number：another random number：B

## ACK
client sends an ACK back to the server.  
sequence number： A+N  
acknowledgement number：B+M

# Connection termination
four-way handshake, with each side of the connection terminating independently.  
![](https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/TCP_CLOSE.svg/520px-TCP_CLOSE.svg.png)

A connection can be "half-open". The terminating side should continue reading the data until the other side terminates as well.

It is also possible to terminate the connection by a 3-way handshake, when host A sends a FIN and host B replies with a FIN & ACK (merely combines 2 steps into one) and host A replies with an ACK.

Some host TCP stacks may implement a half-duplex close sequence, as Linux or HP-UX do. cause the remote stack to lose all the data received.

Some application protocols using the TCP open/close handshaking for the application protocol open/close handshaking may find the RST problem on active close.

# Flow control
receiver continually hints the sender on how much data can be received (controlled by the sliding window). When the receiving host's buffer fills, the next acknowledgment contains a 0 in the window size, to stop transfer and allow the data in the buffer to be processed.

# Window scaling
TCP window size field controls the flow of data and its value is limited to between 2 and 65,535 bytes. 

TCP window scale option, as defined in RFC 1323, is an option used to increase the maximum window size from 65,535 bytes to 1 gigabyte. used only during the TCP 3-way handshake. Both sides must send the option in their SYN segments to enable window scaling in either direction.

Some routers and packet firewalls rewrite the window scaling factor during a transmission. The result is non-stable traffic that may be very slow. 