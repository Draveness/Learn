
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

(define (list-nth-mod xs n)
  (cond ((< n 0) (error "list-nth-mod: negative number"))
        ((null? xs) (error "list-nth-mod: empty list"))
        (else (car (list-tail xs (remainder n (length xs)))))))

(define (stream-for-n-steps s n)
  (if (= n 0)
      null
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

(define (funny-number-stream)
  (define (f x)
      (cons (if (= (remainder x 5) 0) 
                (- x)
                x)
            (lambda () (f (+ x 1)))))
  (f 1))

(define (dan-then-dog)
  (cons "dan.jpg" (lambda () (cons "dog.jpg" dan-then-dog))))

(define (stream-add-zero s)
  (lambda () (cons (cons 0 (car (s))) (stream-add-zero (cdr (s))))))

(define (cycle-lists xs ys)
  (define (f x)
    (cons (cons (list-nth-mod xs x) (list-nth-mod ys x))
          (lambda () (f (+ x 1)))))
  (lambda () (f 0)))

(define (vector-assoc v vec)
  (let ((vec-length (vector-length vec)))
    (define (f x)
      (cond ((> x (- vec-length 1)) #f)
            ((not (pair? (vector-ref vec x))) (f (+ x 1)))
            ((equal? (car (vector-ref vec x)) v) (vector-ref vec x))
            (else (f (+ x 1)))))
    (f 0)))

(define (cached-assoc xs n)
  (letrec ((memo (make-vector n #f))
           (next 0)
           (f (lambda (v)
                (let ((ans (vector-assoc v memo)))
                  (if ans
                      ans
                      (let ((new-ans (assoc v xs)))
                        (begin (vector-set! memo next new-ans)
                               (set! next (remainder (+ next 1) n))
                               new-ans)))))))
    f))

(define-syntax while-less
  (syntax-rules (do)
    ((while-less e1 do e2)
     (let ((e e1))
       (letrec ((loop (lambda ()
                        (if (>= e2 e)
                            #t
                            (loop)))))
       (loop))))))