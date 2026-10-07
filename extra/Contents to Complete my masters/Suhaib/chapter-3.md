# Chapter 3 Questionnaire
## Methodology, Proposed Authentication Mechanism, Implementation and Evaluation

> **Instructions:**  
> Answer only what you know. If something has not yet been decided, write `TBD`.  
> You can answer in simple technical language. I will convert the answers into formal academic writing.
>
> Please do **not** worry about grammar or formatting.

---

# A. Research and Chapter Context

## A1. Research Title

What is the exact/current title of your research?

**Answer: TBD**

---

## A2. Research Problem

In 2–5 sentences, what exact problem is your research trying to solve?

**Answer: This study addresses the following problem: standard ECHONET Lite communication provides an application-level data model for home appliances, but the standard frame does not by itself provide the message authentication, integrity verification, and anti-replay controls required for communication across a potentially untrusted network (echonet_lite_part2). Withoutamechanismthatcombinesoriginverification,message integrity, and freshness validation, an attacker who gains access to the communication path may attempt unauthorized command injection or replay.**

---

## A3. Research Objectives

Please provide your exact research objectives as written in Chapter 1.

**The objectives of this research are to achieve the following: 1. To propose a frame-level security mechanism for ECHONET Lite that provides message authentication and data integrity without changing the protocol’s core object and property model. 2. Toproposeananti-replay andtemporal-validation mechanism within the security extension to reduce the risk of unauthorized command injection and duplicated xivvalid messages. 3. To evaluate the proposed mechanism in terms of security behavior and performanceoverhead, including its effect on latency andoperational efficiency relative to standard ECHONET Lite communication.**

---

## A4. Research Questions

Please provide your exact research questions, if applicable.

**RQ1:**

**RQ2:**

**RQ3:**

**RQ4 (if any):**

There are no research question in the template that I'm following but if there were I would like to answer them as well.
---

## A5. Main Contribution

What is the primary contribution of your research?

For example:

- A new authentication mechanism
- An extension to the ECHONET Lite frame
- A new application-layer security mechanism
- A framework for mitigating specific attacks
- A prototype implementation
- A testbed/evaluation methodology
- Something else

**Answer:*A new authentication mechanism tailored to needs of ECHONET Lite, based on the fact that it is designed for interoperability the mechanism consists of minimal performance overhead*

---

# B. Proposed Authentication Mechanism

## B1. Name of the Proposed Mechanism

What should we call your proposed mechanism throughout the thesis?

Examples:

- ECHONET Lite Authentication Mechanism
- ECHONET Lite Secure Authentication (ELSA)
- ECHONET Lite-A
- Your preferred name

**Answer:*ECHONET Lite Authentication Framework (ELAF)*

---

## B2. Main Security Objectives

Which security properties does your mechanism provide?

Select all that apply and explain if necessary:

- [ ] Authentication
- [ ] Integrity
- [ ] Replay protection
- [ ] Freshness
- [ ] Confidentiality
- [ ] Availability
- [ ] DoS mitigation
- [ ] EDoS mitigation
- [ ] Device authorization
- [ ] Message authenticity
- [ ] Other: _______

**Answer / Explanation:*
- [. ] Authentication
- [. ] Integrity
- [. ] Replay protection
- [ .] Freshness
- [. ] Confidentiality
- [ .] Availability
- [. ] DoS mitigation
- [ .] EDoS mitigation
- [ .] Device authorization
- [ .] Message authenticity

According to my understanding yes it provides all, the core concept basically allows only the devices that are authorized to communiate to each other within the network. Authentication as in the entire model works on a specific symetric key to work. Integrity as in the messages have a SEF secuirty extension field attached to them that is unique to that message due to nonce and timestamp. Replay protection as in whenever a device sends a pattern of requests within 5 second window all the other requests/operations from that devices/user are restricted for a penilty time of 60 seconds. Freshness is based on the timestamp. Confidentiality is based on the Hashing algorithm the SEF is basically encrypted so the even if the message is visible to other devices within the network but would only work for the intended device. Availability also increases as the device are no longer vulnerable. DoS and EDoS mitigation is valid as the devices/users who are trying to make requests are limited to a certain time as perviously mentioned if a device sends a flood of requests those requests will just simply be dropped and ignored. Device authorization is based on SEF as well as the message authenticity 
*

---

## B3. What Exactly Is Authenticated?

What does the HMAC authenticate?

For example:

- Entire ECHONET Lite frame
- ECHONET Lite header
- ECHONET Lite payload
- Authentication block
- Selected fields
- Combination of fields

Please describe exactly what is included in the HMAC input.

**Answer: HMAC authenticates the SEF attached to the ECHONET Lite header**

---

## B4. HMAC Algorithm

What exact HMAC algorithm are you using?

Examples:

- HMAC-SHA-256
- HMAC-SHA-384
- HMAC-SHA-512
- Other

**Answer: HMAC-256 is being used as the primary algorithm but it depends on the manufacterur which mode he/she finds feaseable if a smaller basic version is required then HMAC-256 is truncated to make is smaller the initial to 12 bytes.**

---

## B5. HMAC Output Size

You currently mention:

> HMAC-n / HMAC-96 / truncated HMAC

What is the **actual final HMAC size**?

**Answer: the final size depends on the selected HMAC if it is 96 then only 12 bytes**

---

## B6. HMAC Truncation

If the HMAC is truncated:

1. What is the original HMAC size?
2. What is the truncated size?
3. Which portion is retained?
4. Why was truncation selected?

**Answer: The original HMAC size is 32 bytes of which the truncated version uses initial 12 Bytes**

---

# C. Cryptographic Key Management

## C1. Key Type

Are you using:

- [ ] Pre-shared key (PSK)
- [ ] Dynamically negotiated key
- [ ] Public/private key
- [ ] Other

**Answer: [.] Pre-shared key (PSK), the assumption is made the keys would be pre-shared keys**

---

## C2. Key Distribution

How does a device obtain its key?

For example:

- Pre-configured during manufacturing
- Manually configured
- Stored in device memory
- Distributed by a controller
- Generated during initialization
- Other

**Answer: Yes, Pre-configured during manufacturing**

---

## C3. Key Relationship

Is there:

- One global key shared by all devices?
- One key per device?
- One key per device pair?
- One key per device type?
- One key per communication session?
- Something else?

**Answer: One global key shared by all devices**

---

## C4. Key Size

What is the exact key size?

**Answer: TBD**

---

## C5. Key Storage

Where/how are keys stored in the experimental system?

**Answer: in the experiment the key is configured within the communication model (ECHONET Lite ELAF Version)**

---

## C6. Key Compromise

Does your mechanism address what happens if a device/key is compromised?

If yes, explain.

If no, write `Not addressed`.

**Answer:Not, out of scope**

---

# D. Authentication Frame / Extended Data Structure

Your current design proposes the following fields:

| Field | Size |
|---|---:|
| Version | 1 byte |
| Length | 1 byte |
| Type of Mechanism | 1 byte |
| Timestamp | 4 bytes |
| Counter | 4 bytes |
| HMAC-n | 12 bytes |
| Total | 23 bytes |

Please verify every field below.

---

## D1. Version

What does the Version field represent?

**Answer: Version allows the manufacterers/consumers to choose between the specific versions of ECHONET Lite if they are using the unsecured version then the devices will not be able to communicate with each other if they are will to use it verison 3 in this case the secured version only devices of this version would be able to communicate in a deeper level these devices would share the key.**

---

## D2. Version Value

You mentioned that the secured version may be called Version 3.

Is this final?

**Answer:Yes 3 is the final value**

---

## D3. Length

What exactly does the Length field represent?

- Length of authentication block?
- Length of entire frame?
- Length excluding header?
- Other?

**Answer: Length is basically the size of the entire header after the attached SEF**

---

## D4. Type of Mechanism

Please define exactly what this field represents.

**Answer: this feild is basically for the distinction betwen mechanisms for HMAC such as if user selects 96 he gets the HMAC-256 trucated to 12 bytes and so on.**

---

## D5. Type-of-Mechanism Values

You mentioned examples such as:

- 92
- 128

Are these actual values?

If yes, what exactly do they mean?

**Answer: Yes for now it accepts 92, 128 and 256**

---

## D6. Timestamp

Please specify:

1. Timestamp format:
2. Number of bytes:
3. Unit:
   - [ ] Seconds
   - [ ] Milliseconds
   - [ ] Other
4. Clock source:
5. Allowed clock difference/tolerance:
6. What happens when timestamp validation fails?

**Answer: Timestamp is basically the time when the request is being generated it is set to be in miliseconds, allowed clock difference is 1000 ms due to network and performance delay in the emulated setup**

---

## D7. Counter

Please specify:

1. Counter size:
2. Initial value:
3. Increment rule:
4. Is it maintained per sender?
5. Is it maintained per receiver?
6. Is it maintained per sender-receiver pair?
7. What happens when the counter reaches its maximum?
8. What happens if an old counter value is received?
9. What happens if the counter jumps forward unexpectedly?

**Answer:
Counter size: 4 bytes
Initial value: 0
Increment rule: plus one per request sent
the counter will be updated by the device sending the request (sender)
**

---

## D8. Request Table

You mentioned that each device maintains a request table.

Please describe the exact structure.

For example:

| Field | Purpose |
|---|---|
| Source Device ID | Identifies sender |
| Timestamp | Detects freshness |
| Counter | Detects replay |
| Status | Accepted/rejected |

What fields will actually be stored?

**Answer:

| Field | Purpose |
|---|---|
| Source Device ID | Identifies sender |
| Timestamp | Detects freshness |
| Counter | Detects replay |
| Status | Accepted/rejected |

**

---

## D9. Request Table Lifetime

How long are entries retained?

**Answer: Resets every 5 seconds**

---

## D10. Duplicate Requests

What exactly happens if the same request is received twice?

**Answer: Penalty for 500 miliseconds**

---

# E. Authentication Procedure

## E1. Sender-Side Process

Please describe the exact sequence performed by the sender.

For example:

1. Generate request
2. Add timestamp
3. Increment counter
4. Construct authentication block
5. Calculate HMAC
6. Attach authentication block
7. Transmit frame

Is this correct?

If not, provide the correct sequence.

**Answer: No minor correction the HMAC would be predefined by the manufacturer and it follows it for example the manufacturer has selected 96 then 12 bytes of HMAC is generated and added to the header which is unique everytime.**

---

## E2. Receiver-Side Process

Please provide the exact sequence performed by the receiver.

**Answer:

Recieved request
Validade package
if valid sent a reponse attached with same SEF
if not valid ignore
---

## E3. Authentication Failure

What happens when HMAC verification fails?

**Answer:TBD**

---

## E4. Timestamp Failure

What happens when the timestamp is invalid/expired?

**Answer: Packet ignored or in terms of ECHONET Lite the data frame would be ignored**

---

## E5. Counter Failure

What happens when the counter indicates a replay or invalid sequence?

**Answer: Packet ignored or in terms of ECHONET Lite the data frame would be ignored**

---

## E6. Version Mismatch

What happens when two devices have different authentication versions?

**Answer: the devices will not be able to communicate with each other**

---

## E7. Mechanism-Type Mismatch

What happens when two devices use different authentication mechanisms?

**Answer:the devices will not be able to communicate with each other**

---

# F. DoS / EDoS Defense

This is an important part of your proposed contribution and needs to be described precisely.

## F1. Request Threshold

You currently mention:

> More than 5 requests to one device within 3 seconds.

Is this your final threshold?

**Answer: I don't know how to explain it if possible you can write it up in words if you have understood the mechanism**

---

## F2. Threshold Logic

Is the threshold:

- 5 requests per 3 seconds?
- More than 5 requests per 3 seconds?
- 5 requests within a sliding window?
- Something else?

**Answer: yes 5 requests per 3 seconds**

---

## F3. Suspended Device

When a device exceeds the threshold:

1. Is the **sender** blocked?
2. Is the **receiver** protected?
3. Are all requests blocked?
4. Only requests from that particular sender?
5. How long?

**Answer: sender blocked**

---

## F4. Suspension Duration

You mentioned 30 seconds.

Is this final?

**Answer: In the emulated version it works well against attacks**

---

## F5. What Happens After Suspension?

After 30 seconds:

- Is the sender automatically allowed again?
- Must authentication occur again?
- Is the counter reset?
- Is the device permanently flagged?
- Other?

**Answer: Must authentication occur again, broadcast itself to show it is available for communication again.**

---

## F6. Legitimate High-Frequency Traffic

How does your mechanism distinguish legitimate high-frequency traffic from an attack?

**Answer: No.**

---

## F7. EDoS Definition

What specifically do you mean by EDoS in your thesis?

Please provide your intended definition.

**Answer: Economic Denial of Service meaning that someone can try to use the highest settings of the devices such as Air conditioner when he know the user is not present at the premesis**

---

## F8. EDoS Defense

Explain exactly how your mechanism mitigates EDoS.

**Answer: The SEF in its entirity with everything helps mitigate it. I don't know the exact words how to frame this**

---

# G. Replay Attack Defense

## G1. Replay Scenario

Describe the exact replay attack you intend to simulate.

**Answer:**

---

## G2. Replay Detection

Which mechanism detects replay?

- [ ] Timestamp
- [ ] Counter
- [ ] Request table
- [ ] HMAC
- [ ] Combination
- [ ] Other

**Answer:**

---

## G3. Replay Response

What does the receiver do after detecting a replayed message?

**Answer:**

---

# H. AI-Based Attack Detection

Your notes mention an AI-based algorithm for certain devices.

This needs clarification before it can be included academically.

## H1. Is AI Actually Part of the Proposed System?

- [ ] Yes, implemented and evaluated
- [ ] Yes, implemented but not evaluated
- [ ] Proposed future component only
- [ ] Conceptual idea only
- [ ] Remove AI from Chapter 3

**Answer:**

---

## H2. AI Algorithm

If implemented, which algorithm/model is used?

Examples:

- Random Forest
- SVM
- Neural Network
- Decision Tree
- Isolation Forest
- Autoencoder
- Other

**Answer:**

---

## H3. AI Input Features

What data/features are supplied to the AI model?

**Answer: NO**

---

## H4. AI Output

What exactly does the AI determine?

**Answer:**

---

## H5. Training Dataset

Where does the training data come from?

**Answer:**

---

## H6. Training/Test Split

What split is used?

**Answer:**

---

## H7. AI Evaluation Metrics

What metrics are used?

- [ ] Accuracy
- [ ] Precision
- [ ] Recall
- [ ] F1-score
- [ ] ROC-AUC
- [ ] False positive rate
- [ ] False negative rate
- [ ] Other

**Answer:**

---

# I. ECHONET Lite Details

## I1. ECHONET Lite Version

Which version/specification of ECHONET Lite are you using?

**Answer:**

---

## I2. Message Type

Which ECHONET Lite messages/operations are used in your experiments?

**Answer:**

---

## I3. Target Devices

What types of devices are represented?

For example:

- Smart meter
- Ambient light sensor
- Air conditioner
- Lighting device
- Controller
- Other

**Answer:**

---

## I4. ECHONET Lite Frame

Which exact part of the ECHONET Lite frame is being modified?

Please explain.

**Answer:**

---

## I5. Backward Compatibility

Can an ordinary ECHONET Lite device communicate with your secured device?

If not, explain why.

**Answer:**

---

# J. Proposed Architecture

## J1. Main Components

Please list every component in your proposed architecture.

Example:

- auth_controller
- translator
- auth_ambient_light
- ECHONET Lite devices
- Network
- Attacker
- Other

**Answer:**

---

## J2. Component Responsibilities

For each component, explain its responsibility.

### Component 1:
**Name:**

**Purpose:**

### Component 2:
**Name:**

**Purpose:**

### Component 3:
**Name:**

**Purpose:**

### Component 4:
**Name:**

**Purpose:**

---

## J3. Translator

You mentioned a translator that receives authenticated requests and forwards them to actual devices.

Please explain:

1. Why is the translator necessary?
2. What protocol does it receive?
3. What protocol does it forward?
4. Does it modify the message?
5. Does it perform authentication?
6. Does it maintain state?
7. Is it part of the final proposed architecture or only required because real devices are unavailable?

**Answer:**

---

# K. Simulation Environment

## K1. Containerization

You mentioned Docker.

What exactly is containerized?

**Answer:**

---

## K2. Operating System

What OS is used?

**Answer:**

---

## K3. Programming Language

What programming language(s) are used?

**Answer:**

---

## K4. Libraries / Frameworks

List the major libraries/frameworks used.

Example:

- Python
- Docker
- Scapy
- Flask
- HMAC library
- ECHONET Lite library
- Other

**Answer:**

---

## K5. Number of Containers

How many containers are used?

**Answer: