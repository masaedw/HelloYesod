{-# LANGUAGE QuasiQuotes, TypeFamilies, GeneralizedNewtypeDeriving, TemplateHaskell, OverloadedStrings, GADTs #-}
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Data.Time
import Control.Monad.IO.Class

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persist|
Person
    name String
    age Int Maybe
    created UTCTime default='now'
|]

main = withSqliteConn ":memory:" $ runSqlConn $ do
    time <- liftIO getCurrentTime
    runMigration migrateAll
    insert $ Person "Michael" (Just 26) time
    gregId <- insert $ Person "Greg" Nothing time
    greg <- get gregId
    liftIO $ print greg
