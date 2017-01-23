;;; main.scm    source of wars.scm
(use coops)

(define-class <unit> ()
  ([attack-range	#:initform 0  #:accessor attack-range]
   [bullet-cost		#:initform 0  #:accessor bullet-cost]
   [price			#:initform 0  #:accessor price]      
   ;; 以下 増減あり
   [number-limit	#:initform 10 #:accessor number-limit]
   [number			#:initform 0  #:accessor number]
   [bullet-limit	#:initform 0  #:accessor bullet-limit]
   [bullet			#:initform 0  #:accessor bullet]
   [fuel-limit		#:initform 0  #:accessor fuel-limit]
   [fuel			#:initform 0  #:accessor fuel]
   [mobility-limit	#:initform 0  #:accessor mobility-limit]
   [mobility		#:initform 0  #:accessor mobility]))


(define-method (initialize-instance (u <unit>))
  (call-next-method)
  (set! (number   u) (number-limit   u))
  (set! (bullet   u) (bullet-limit   u))
  (set! (fuel	  u) (fuel-limit     u))
  (set! (mobility u) (mobility-limit u)))

(define-method (print-object (u <unit>) p)
  (with-output-to-port p
	(lambda ()
	  (printf "数 ~A, 移動 ~A, 燃料 ~A, 弾薬 ~A"
			  (number u)
			  (mobility u)
			  (fuel u)
			  (bullet u)))))


;;; bullet-limit attack-range fuel-limit mobility-limit bullet-cost price
(define-syntax define-unit
  (syntax-rules ()
	[(_ name blt atr fl mb bc pr)
	 (define-class name (<unit>)
	   ([bullet-limit #:initform blt]
		[attack-range #:initform atr]
		[fuel-limit #:initform fl]
		[mobility-limit #:initform mb]
		[bullet-cost #:initform bc]
		[price #:initform pr]))]))
;;; http://rtgame.web.fc2.com/capture/famwars/unit1.html
;;; 歩兵
(define-unit <infantry> 9 1 99 3 1 1000)
;;; 戦闘工兵
(define-unit <sapper> 3 1 70 2 3 2000)
;;; 戦車 A,B
(define-unit <tank-a> 6 1 70 6 5 16000)
(define-unit <tank-b> 4 1 50 5 4 6000)
;;; 装甲輸送車, Armoured personal carrier
(define-unit <apc> 4 1 70 6 3 4200)
;;; 自走砲 A, B, self-propelled artillery
(define-unit <spa-a> 5 '(3 . 5) 50 4 7 13000)
(define-unit <spa-b> 3 '(2 . 3) 30 5 6 5500)
;;; 対空ミサイル,  surface-to-air missile (SAM)
(define-unit <sam> 2 '(3 . 5) 40 4 8 11000)
;;; 高射砲 Fliegerabwehrkanone FLAK
(define-unit <flak> 4	1	50	5	3	5500)
;;; 補給車
(define-unit <supply-vehicle> #f #f 60 5 #f 3000)
;;; 戦闘機A,B
(define-unit <fighter-a> 5	1	99	10	8	22000)
(define-unit <fighter-b> 4	1	99	10	8	15000)
;;; 爆撃機
(define-unit <bomber> 5	1	99	8	6	20000)
;;; 輸送ヘリ
(define-unit <transport-copter> 4	1	60	6	3	4000)
;;; 戦艦
(define-unit <buttle-ship> 6	'(3 . 5)	99	6	6	28800)
;;; 揚陸艦
(define-unit <landing-ship> 6	1	99	5	3	18500)



