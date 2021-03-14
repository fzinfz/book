
<!-- TOC -->

- [Protocol Operation](#protocol-operation)
    - [Connection establishment](#connection-establishment)
    - [Connection termination](#connection-termination)
- [TCP segment structure](#tcp-segment-structure)
    - [Source port (16 bits)](#source-port-16-bits)
    - [Destination port (16 bits)](#destination-port-16-bits)
    - [Sequence number (32 bits)](#sequence-number-32-bits)
    - [Acknowledgment number (32 bits)](#acknowledgment-number-32-bits)
    - [Data offset (4 bits)](#data-offset-4-bits)
    - [Reserved (3 bits)](#reserved-3-bits)
    - [Flags (9 bits) (aka Control bits)](#flags-9-bits-aka-control-bits)
    - [Window size (16 bits)](#window-size-16-bits)
        - [Window scaling (in Options)](#window-scaling-in-options)
    - [Checksum (16 bits)](#checksum-16-bits)
    - [Urgent pointer (16 bits)](#urgent-pointer-16-bits)
    - [Options](#options)
    - [Padding](#padding)
- [Flow control](#flow-control)

<!-- /TOC -->

# Protocol Operation
A TCP connection is managed by an operating system through socket.   
http://www.medianet.kent.edu/techreports/TR2005-07-22-tcp-EFSM.pdf

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Tcp_state_diagram_fixed_new.svg/1592px-Tcp_state_diagram_fixed_new.svg.png)

## Connection establishment
three-way (or 3-step) handshake:

    client sending a SYN to the server     | Seq=A
    server replies with a SYN-ACK          | ACK=A+N | Seq=B
    client sends an ACK back to the server | Seq=A+N | ACK=B+M

## Connection termination
![](https://upload.wikimedia.org/wikipedia/commons/5/55/TCP_CLOSE.svg)

four-way handshake, with each side of the connection terminating independently.  

A connection can be "half-open". The terminating side should continue reading the data until the other side terminates as well.

It is also possible to terminate the connection by a 3-way handshake, when host A sends a FIN and host B replies with a FIN & ACK (merely combines 2 steps into one) and host A replies with an ACK.

Some host TCP stacks may implement a half-duplex close sequence, as Linux or HP-UX do. cause the remote stack to lose all the data received.

Some application protocols using the TCP open/close handshaking for the application protocol open/close handshaking may find the RST problem on active close.

# TCP segment structure
https://en.wikipedia.org/wiki/Transmission_Control_Protocol  
![](https://i.imgur.com/zPm8dKA.png)

## Source port (16 bits)

## Destination port (16 bits)

## Sequence number (32 bits)
- If the SYN flag is set (1), then this is the initial sequence number. The sequence number of the actual first data byte and the acknowledged number in the corresponding ACK are then this sequence number plus 1.
- If the SYN flag is clear (0), then this is the accumulated sequence number of the first data byte of this segment for the current session.

## Acknowledgment number (32 bits)
If the ACK flag is set then the value of this field is the next sequence number that the sender is expecting. This acknowledges receipt of all prior bytes (if any). The first ACK sent by each end acknowledges the other end's initial sequence number itself, but no data.

## Data offset (4 bits)
Specifies the size of the TCP header in 32-bit words.  
The minimum size header is 5 words and the maximum is 15 words thus giving the minimum size of 20 bytes and maximum of 60 bytes, allowing for up to 40 bytes of options in the header. （？）  
also the offset from the start of the TCP segment to the actual data.

## Reserved (3 bits)
For future use and should be set to zero.

## Flags (9 bits) (aka Control bits)
- NS(1 bit): ECN-nonce - concealment protection  
https://tools.ietf.org/html/rfc3540  
Robust Explicit Congestion Notification (ECN) Signaling with Nonces

   The ECN-nonce enables the sender to verify the correct behavior of
   the ECN receiver and that there is no other interference that
   conceals marked (or dropped) packets in the signaling path.

- CWR(1 bit): Congestion Window Reduced (CWR)  
set by the sending host to indicate that it received a TCP segment with the ECE flag set and had responded in congestion control mechanism (added to header by RFC 3168).

- ECE (1 bit): ECN-Echo  
has a dual role:
- If the SYN flag is set (1), that the TCP peer is ECN capable.
- If the SYN flag is clear (0), that a packet with Congestion Experienced flag set (ECN=11) in IP header was received during normal transmission (added to header by RFC 3168). This serves as an indication of network congestion (or impending congestion) to the TCP sender.

- URG (1 bit)  
indicates that the Urgent pointer field is significant

- ACK (1 bit)  
indicates that the Acknowledgment field is significant.  
*All packets after the initial SYN packet sent by the client should have this flag set.*

- PSH (1 bit): Push functio你 
Asks to push the buffered data to the receiving application.

- RST (1 bit): Reset the connection  

- SYN (1 bit): Synchronize sequence numbers  
Only the first packet sent from each end should have this flag set.   
Some other flags and fields change meaning based on this flag, and some are only valid for when it is set, and others when it is clear.

- FIN (1 bit): Last packet from sender  

## Window size (16 bits)
 the number of window size units(by default, bytes) (beyond the segment identified by the sequence number in the acknowledgment field) that *the sender of this segment is currently willing to receive* (see Flow control and Window Scaling).

### Window scaling (in Options)
TCP window size field controls the flow of data and its value is limited to between 2 and 65,535 bytes. 

TCP window scale option, as defined in RFC 1323, is an option used to increase the maximum window size from 65,535 bytes to 1 gigabyte. used only during the TCP 3-way handshake. Both sides must send the option in their SYN segments to enable window scaling in either direction.

Some routers and packet firewalls rewrite the window scaling factor during a transmission. The result is non-stable traffic that may be very slow. 

## Checksum (16 bits)

    error-checking of the header, the Payload and a Pseudo-Header.  
        The Pseudo-Header consist of：
            the Source IP Address, 
            the Destination IP Address, 
            the protocol number for the TCP-Protocol (0x0006) 
            the length of the TCP-Headers including Payload (in Bytes)

## Urgent pointer (16 bits)
if the [URG](#urg-1-bit) flag is set, then this 16-bit field is an offset from the sequence number indicating the last urgent data byte.

## Options
Variable 0–320 bits, divisible by 32
if data offset > 5. Padded at the end with "0" bytes if necessary.

## Padding
Zeros. ensure that the TCP header ends and data begins on a 32 bit boundary.

# Flow control
receiver continually hints the sender on how much data can be received (controlled by the sliding window). When the receiving host's buffer fills, the next acknowledgment contains a 0 in the window size, to stop transfer and allow the data in the buffer to be processed.
