# **Greenwich Token (GRN)**  

### **Overview**  
The **Greenwich Token (GRN)** is a fungible token implemented in Clarity, designed to facilitate access to premium information resources (such as PDFs and eBooks) through an on-chain payment mechanism. This contract ensures secure token transfers, manages resource access, and includes a deflationary burn mechanism upon purchases.  

---

## **Key Features**  
- **Fungible Token Implementation** – Clarity-based token with a total supply of **21,000 GRN**.  
- **Resource Access Control** – Users can purchase access to digital resources using GRN tokens.  
- **Deflationary Model** – Tokens used for purchases are burned, reducing total supply.  
- **Ownership Security** – Enhanced checks to prevent unauthorized transactions.  
- **Access Verification** – Users can check if they have access to a specific resource.  

---

## **Contract Details**  

### **1. Token Definition**  
The Greenwich token is defined as a **fungible token** with a **fixed supply** of **21,000 GRN**. The contract deployer is the initial recipient of all tokens.  

- **Token Name**: Greenwich  
- **Symbol**: GRN  
- **Decimals**: 6  
- **Total Supply**: 21,000 GRN  

---

## **Functions**  

### **1. `get-name`**  
📌 *Returns the name of the token.*  
- **Returns**: `"Greenwich"`  

### **2. `get-symbol`**  
📌 *Returns the token symbol.*  
- **Returns**: `"GRN"`  

### **3. `get-decimals`**  
📌 *Returns the number of decimal places (6 decimals).*  
- **Returns**: `u6`  

### **4. `get-total-supply`**  
📌 *Returns the total supply of the token.*  
- **Returns**: `u21000`  

### **5. `get-balance (owner principal)`**  
📌 *Checks the balance of a given user.*  
- **Parameters**:  
  - `owner` – The principal address of the user.  
- **Returns**: Token balance of the user.  

---

## **Token Transfer Function**  

### **6. `transfer (amount uint) (sender principal) (recipient principal)`**  
📌 *Securely transfers tokens between users with additional checks.*  
- **Parameters**:  
  - `amount` – Number of tokens to transfer.  
  - `sender` – The principal sending tokens.  
  - `recipient` – The principal receiving tokens.  
- **Requirements**:  
  - `tx-sender` must match the `sender`.  
  - `amount` must be greater than `0`.  
  - Sender must have a sufficient balance.  
  - Recipient must not be the zero address.  
- **Returns**: Transaction success or error code.  

---

## **Resource Access Management**  

### **7. `has-access (user principal) (resource-id uint) → bool`**  
📌 *Checks if a user has access to a specific resource.*  
- **Parameters**:  
  - `user` – Principal address of the user.  
  - `resource-id` – ID of the resource.  
- **Returns**:  
  - `true` – If the user has access.  
  - `false` – Otherwise.  

### **8. `purchase-access (resource-id uint) (token-price uint)`**  
📌 *Allows a user to purchase access to a resource by paying tokens.*  
- **Parameters**:  
  - `resource-id` – The ID of the resource.  
  - `token-price` – The price in GRN tokens.  
- **Requirements**:  
  - The `token-price` and `resource-id` must be valid (greater than `0`).  
  - The user must not already have access.  
  - The user must have enough tokens.  
- **Process**:  
  - Tokens are **burned** instead of being transferred.  
  - The user gains access to the resource.  
- **Returns**: Transaction success or error code.  

---

## **Security Measures**  
- Ensures only the correct sender can initiate transfers.  
- Prevents sending tokens to the zero address.  
- Burns tokens instead of storing them, ensuring deflationary mechanics.  
- Uses Clarity’s **read-only functions** for secure balance and access verification.  

---

## **Deployment Considerations**  
- This contract is built for the **Stacks blockchain** using Clarity.  
- Once deployed, **all logic is immutable** – no upgrades possible.  
- Resource management is handled through **Clarity maps**, ensuring efficiency.  

---

### **Conclusion**  
The **Greenwich Token (GRN)** serves as a decentralized, deflationary token for purchasing digital resources on-chain. With built-in security, transparent access control, and a sustainable burn model, this contract ensures a seamless and trustless user experience. 🚀
