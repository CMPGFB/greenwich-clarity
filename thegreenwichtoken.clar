;; Greenwich Token Contract
;; Inspired by the NoCodeDevs at the University of Greenwich | Circa 2024 - 2025
;; A utility token that grants holders access to information in the form of PDFs or eBooks
;; Total supply: 21,000 tokens

(define-fungible-token greenwich u21000)

;; Token information
(define-read-only (get-name)
  (ok "Greenwich"))

(define-read-only (get-symbol)
  (ok "GRN"))

(define-read-only (get-decimals)
  (ok u6))

(define-read-only (get-total-supply)
  (ok u21000))

;; Return the token balance of the owner
(define-read-only (get-balance (owner principal))
  (ok (ft-get-balance greenwich owner)))

;; Transfer tokens to a recipient with enhanced security
(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    ;; Verify that the transaction sender is the specified sender
    (asserts! (is-eq tx-sender sender) (err u4))
    
    ;; Check that the amount is greater than zero
    (asserts! (> amount u0) (err u5))
    
    ;; Check that sender has enough balance
    (asserts! (>= (ft-get-balance greenwich sender) amount) (err u6))
    
    ;; Check that recipient is not the zero address
    (asserts! (not (is-eq recipient 'SP000000000000000000002Q6VF78)) (err u7))
    
    ;; Execute the transfer
    (ft-transfer? greenwich amount sender recipient)))

;; Initial token allocation to contract deployer
(begin
  (try! (ft-mint? greenwich u21000 tx-sender))
  (print "Greenwich tokens minted successfully"))

;; Access control for information resources - use a map instead of a list
(define-map user-resource-access {user: principal, resource-id: uint} {has-access: bool})

;; Check if a user has access to a specific resource
(define-read-only (has-access (user principal) (resource-id uint))
  (default-to 
    false
    (get has-access (map-get? user-resource-access {user: user, resource-id: resource-id}))))

;; Grant access to a resource (requires token payment)
(define-public (purchase-access (resource-id uint) (token-price uint))
  (begin
    ;; Validate inputs
    (asserts! (> token-price u0) (err u8))
    (asserts! (> resource-id u0) (err u9))
    
    ;; Check if user already has access
    (asserts! (not (has-access tx-sender resource-id)) (err u1))
    
    ;; Check if user has enough tokens
    (asserts! (>= (ft-get-balance greenwich tx-sender) token-price) (err u6))
    
    ;; Process token payment (burn tokens)
    (try! (ft-burn? greenwich token-price tx-sender))
    
    ;; Grant access by setting the map entry
    (map-set user-resource-access 
             {user: tx-sender, resource-id: resource-id}
             {has-access: true})
    
    (ok true)))
