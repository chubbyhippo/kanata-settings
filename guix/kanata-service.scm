(define-module (kanata-service)
  #:use-module (gnu services)
  #:use-module (gnu services desktop)
  #:use-module (guix gexp)
  #:export (kanata-settings-service))

(define kanata-settings-service
  (service kanata-service-type
           (kanata-configuration
            (keymaps (list (local-file "../kanata.kbd"))))))
