;; winning-mini-rfp.clar
;; Brief & unique contract for fair RFP bidding on Google Clarity Web3

(clarity-version 2)

(define-data-var rfp-id uint u0)
(define-map rfps ((id uint)) ((owner principal) (winner (optional principal))))
(define-map commits ((id uint) (vendor principal)) ((hash (buff 32))))
(define-map reveals ((id uint) (vendor principal)) ((proposal (string-utf8 40))))

;; Create a new RFP
(define-public (create-rfp)
  (let ((id (+ (var-get rfp-id) u1)))
    (map-set rfps { id: id } { owner: tx-sender, winner: none })
    (var-set rfp-id id)
    (ok id)))

;; Commit a proposal (hash = sha256(proposal || salt))
(define-public (commit (id uint) (hash (buff 32)))
  (map-set commits { id: id, vendor: tx-sender } { hash: hash })
  (ok true))

;; Reveal a proposal
(define-public (reveal (id uint) (proposal (string-utf8 40)) (salt (buff 32)))
  (match (map-get? commits { id: id, vendor: tx-sender })
    somec (if (is-eq (get hash somec) (sha256 (concat (utf8-to-bytes proposal) salt)))
             (begin (map-set reveals { id: id, vendor: tx-sender } { proposal: proposal }) (ok true))
             (err u100))
    none (err u101)))

;; Finalize and record winner
(define-public (finalize (id uint) (winner principal))
  (let ((r (unwrap! (map-get? rfps { id: id }) (err u102))))
    (asserts! (is-eq (get owner r) tx-sender) (err u103))
    (map-set rfps { id: id } { owner: tx-sender, winner: (some winner) })
    (ok winner)))
