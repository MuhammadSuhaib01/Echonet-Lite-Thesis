# Chapters 4–6 Questionnaire
## Implementation, Results and Conclusion

> **How to answer:** Write under each **Answer:** line. Simple language is fine.
> If you don't know, write `TBD`. If a question asks for data, you can paste the numbers,
> paste a table, or give the path of a file (CSV, Excel, log, screenshot) inside the repo.
>
> **Most important sections:** E (results data) and C1 (what the HMAC covers).
> Chapter 5 cannot be written without section E. Nothing will be estimated or made up.

---

# A. Implementation Environment (Chapter 4)

## A1. Host machine
CPU model, RAM, and operating system (with version) of the computer running Docker.

**Answer:**

## A2. Docker
Docker version, and the network mode used (default bridge, user-defined bridge, macvlan, …).
Do you use `docker-compose`? If yes, how many services does it start?

**Answer:**

## A3. IP addresses
You wrote that `emu1` runs on `172.168.0.1` and `emu2` on `172.168.0.2`.
Please confirm the exact addresses. Note: `172.168.x.x` is a **public** address range;
Docker private networks normally use `172.16.x.x`–`172.31.x.x` (e.g., `172.18.0.2`).
Was it maybe `172.18.0.x`? A screenshot of `docker network inspect` would settle it.

**Answer:**

## A4. Emulator
1. What is the exact name and version of the emulator? (`emu_echonet_lite`? Is it the same as "Elemu 1.1.0" in your Chapter 3 diagram?)
2. Where did it come from (GitHub link / your own code / supervisor's code)?
3. Which ECHONET Lite device objects does each instance emulate (e.g., controller 0x05FF01, air conditioner 0x013001, lighting 0x029001)?
4. How many emulator instances run at the same time in the experiments?

**Answer:**

## A5. Programming language and libraries
Language and version (e.g., Python 3.11), and the main libraries used for:
- HMAC / hashing (e.g., `hmac`, `hashlib`)
- DTLS (library name and version)
- JWT (e.g., `PyJWT` version)
- Packet crafting (Scapy?)
- Timing (e.g., `time.perf_counter()`)

**Answer:**

## A6. SSNG and Wireshark
SSNG version, and how it was used (manual GUI clicks, scripted, how many packets).
Wireshark version. Did you capture screenshots of ELAF / DTLS / JWT frames? (Paths please.)

**Answer:**

## A7. Physical testbed (Raspberry Pi)
1. Has the Raspberry Pi testbed (auth_controller + translator + real appliances) actually been run yet?
2. If yes, are there results from it? If not, should Chapter 4 describe it as planned / future work?
3. Number of real devices: your draft says **8**, the diagram shows **3 AC + 4 lights + 1 light controller + 1 air purifier = 9**. Which is correct?

**Answer:**

---

# B. The Four Compared Modes (Chapter 4)

You said the emulator reads **the bytes after the ECHONET Lite data frame** as the security trailer
(SEF for ELAF, or the DTLS / JWT data). Thank you, that answered the placement question.

## B1. How does the receiver find the end of the ECHONET Lite frame?
Is it computed by parsing OPC and each PDC (standard Format 1 parsing), or in another way?

**Answer:**

## B2. Native mode
Is "Native" plain standard ECHONET Lite with no trailer at all?

**Answer:**

## B3. DTLS mode
This needs care, because real DTLS normally *wraps* the whole message (handshake + encrypted record),
it does not sit after the frame.
1. Is it a real DTLS library session (with handshake), or a DTLS-style record/fields appended after the frame?
2. DTLS version (1.2 / 1.3) and cipher suite (e.g., PSK-AES128-CCM8)?
3. Is the payload encrypted in this mode?
4. How many bytes does the DTLS part add per message?
5. Is the handshake time included in the latency measurement?

**Answer:**

## B4. JWT mode
1. Signing algorithm (e.g., HS256 = HMAC-SHA-256)?
2. Which claims are in the token (e.g., `iat`, `exp`, `jti`, a hash of the frame)?
3. Is the ECHONET Lite frame itself covered by the signature, or only the token claims?
4. Is the token appended as text (base64url) or converted to bytes?
5. How many bytes does the JWT add per message?
6. Does JWT mode have any replay protection (e.g., `exp`, `jti` check)?

**Answer:**

## B5. ELAF mode
Which ToM was used in the experiments (96 → 12-byte tag / 23-byte SEF; 128; 256)? Was more than one tested?

**Answer:**

---

# C. Open Items from Chapter 3 (please confirm against the code)

## C1. HMAC input — MOST IMPORTANT
Does the HMAC cover **(a)** only the SEF fields, or **(b)** the SEF fields **and** the ECHONET Lite frame?
If only (a), an attacker can change the command (ESV/EDT) and keep a valid SEF, so integrity is not provided.
Chapter 3 currently assumes (b).

**Answer:**

## C2. Timestamp
Seconds or milliseconds? If milliseconds in 4 bytes, is it relative (e.g., ms since boot) or truncated?

**Answer:**

## C3. ToM code value
Is the 12-byte mode coded as **92** or **96**?

**Answer:**

## C4. Rate limit
Final values: 5 requests in **3 s** → **30 s** suspension? (Another answer said 5 s / 60 s.)
Does the 5th or the 6th request trigger suspension?

**Answer:**

## C5. Response SEF
Does the response carry a **new** SEF (new timestamp, counter, tag), or a copy of the request's SEF?

**Answer:**

## C6. Source identifier
What identifies the sender in the request table: IP address, SEOJ, or something else?

**Answer:**

## C7. Order of checks and comparison
Does the receiver check version/ToM/length → suspension → timestamp → duplicate → HMAC → rate, as in Algorithm 3.1?
Is the tag compared with a constant-time function (e.g., `hmac.compare_digest`)?

**Answer:**

## C8. Key size
Length of the shared key in bytes (e.g., 32 bytes)?

**Answer:**

---

# D. Experiment Design (Chapter 4 / 5)

## D1. Messages used
Which ESV and properties were sent (e.g., Get 0x62 of EPC 0x80 operation status; SetC 0x61 of 0x80 = 0x30 ON)?
What is the size in bytes of the native test frame?

**Answer:**

## D2. Repetitions
How many times was each experiment repeated (e.g., 20 runs × 100 messages)?

**Answer:**

## D3. How latency was measured
Round-trip time (request sent → response received) at the controller? Measured in code or from Wireshark timestamps?

**Answer:**

## D4. How processing time was measured
Was the time for building the trailer (sender) and verifying it (receiver) measured separately?

**Answer:**

## D5. How throughput was measured
E.g., number of responses received per second while sending N requests as fast as possible.

**Answer:**

## D6. Attack tests performed
For each, describe what you did and how many packets:
1. Unauthenticated injection with SSNG (you said native devices respond, the others ignore it)
2. Replay (captured a valid frame and re-sent it? after how long?)
3. Flooding / DoS (rate, duration, tool)
4. EDoS scenario (e.g., SetC to an air conditioner)
5. Modified frame (changed EDT but kept the trailer)?

**Answer:**

---

# E. Results Data (Chapter 5) — please paste numbers or give file paths

## E1. Frame size per mode (bytes)
| Mode | Native frame | Added bytes | Total frame |
|---|---|---|---|
| Native | | 0 | |
| ELAF | | | |
| DTLS | | | |
| JWT | | | |

## E2. Latency per mode (ms)
| Mode | Min | Max | Mean | SD | Runs |
|---|---|---|---|---|---|
| Native | | | | | |
| ELAF | | | | | |
| DTLS | | | | | |
| JWT | | | | | |

## E3. Processing time per mode (ms)
| Mode | Sender mean | Sender SD | Receiver mean | Receiver SD |
|---|---|---|---|---|
| Native | | | | |
| ELAF | | | | |
| DTLS | | | | |
| JWT | | | | |

## E4. Throughput per mode (messages/s)
| Mode | Normal traffic | Under flooding |
|---|---|---|
| Native | | |
| ELAF | | |
| DTLS | | |
| JWT | | |

## E5. Attack results per mode
For each attack: packets sent, packets that got a response / changed the device state.
| Attack | Native | ELAF | DTLS | JWT |
|---|---|---|---|---|
| Unauthenticated injection (SSNG) | | | | |
| Replay | | | | |
| Flooding | | | | |
| Modified frame | | | | |

## E6. Legitimate messages wrongly rejected (false positives)
Did any legitimate message get rejected (e.g., clock drift, rate limit)? How many?

**Answer:**

## E7. Screenshots / figures available
List any graphs, Wireshark screenshots or terminal outputs you want in Chapter 5 (paths).

**Answer:**

---

# F. Conclusion (Chapter 6)

## F1. Future work you want to mention
E.g., AI-based anomaly detection on capable devices, per-device keys / key management,
payload encryption, adaptive rate thresholds, implementation on real appliance firmware,
proposal to the ECHONET Consortium. Add or remove.

**Answer:**

## F2. Publications
Any paper published / submitted from this work (for the List of Publications)?

**Answer:**
