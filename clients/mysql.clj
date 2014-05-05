;; lein repl

;; (use 'clojure.java.jdbc)
(use 'clojure.java.jdbc.deprecated)
 
 (let [db-host "localhost"
      db-port 3306
      db-name "caption_me"]
 
      (def db {:classname "com.mysql.jdbc.Driver" ; must be in classpath
               :subprotocol "mysql"
               :subname (str "//" db-host ":" db-port "/" db-name)
               :user "root"
               :password ""}))

(with-connection db 
      (with-query-results rs ["select * from tbl_videos"] 
           (doseq [row rs] (println (:video_name :video_description row)))))
