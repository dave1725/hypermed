# Patient-Centric Healthcare Data Exchange Protocol (DLT + IPFS + RAG)

Status: Private/Pre-release
> In Research and Development (R&D)

## Overview
This project explores a patient-centric protocol for secure healthcare data exchange that combines:
- Distributed Ledger Technology (DLT) for tamper-evident consent, audit, and governance
- IPFS for content-addressed, off-chain storage of clinical artifacts
- Retrieval-Augmented Generation (RAG) to safely surface context-aware insights from authorized data

The goal is to give patients ownership and fine-grained control over who can access their data, when, and for what purpose, while enabling interoperable, verifiable exchange for care teams, payers, and researchers.

## Core Features (planned)
- Patient-owned identity, consent, and delegation policies
- FHIR-compatible data packaging and validation
- Immutable audit trail on DLT (e.g., Hyperledger Fabric)
- Content-addressed storage on IPFS with encryption-at-rest
- Policy-enforced access brokering and verifiable disclosures
- RAG assistant for clinicians/researchers constrained to authorized data

## Architecture at a Glance
- Control Plane: DLT smart contracts for consent, policies, and audit
- Data Plane: IPFS for large clinical payloads; keys and references anchored on-ledger
- Access Gateway: broker enforcing consent and purpose-of-use, issuing scoped tokens
- AI Layer: RAG pipeline retrieving only permitted content, with safety and provenance

## Tech Stack (initial)
- DLT: Hyperledger Fabric (samples, chaincode)
- Storage: IPFS (local or managed pinning)
- Services: Chaincode with Javascript
- AI: RAG components (vector store, retrieval, prompt orchestration)

## Getting Started
This repository is in early preparation. Setup scripts and modules will be published as the MVP stabilizes.

Prerequisites (anticipated):
- Docker and Docker Compose
- Node.js 18+ / Go 1.22+
- IPFS node (or gateway/pinning provider)
- Basic Fabric dev environment for local networks

## Project Status
Pre-Alpha: active design and prototyping. 
```Interfaces and components will change.```

## Roadmap (high-level)
1. MVP: consent registry + IPFS broker + minimal gateway
2. FHIR resources ingestion/validation and encryption key management
3. Audit/trace UI and export pipeline
4. RAG pipeline with safety/provenance and evaluation harness
5. Public documentation and open-source release

## Contributing
External contributions are not accepted yet while the design stabilizes. The project is intended to be open-sourced in the near future guidelines will be shared at that time.

## Copyright and Notice
Copyright (c) 2025. All rights reserved.

This project is currently proprietary and copyrighted. No copying, distribution, or derivative works are permitted without explicit written permission from the project owners. The maintainers intend to release this project under an open-source license in the future. Until that formal license is published, all rights are reserved.

For questions about evaluation access or licensing, please contact the maintainers.

