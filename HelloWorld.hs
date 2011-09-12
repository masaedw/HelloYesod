{-# LANGUAGE TypeFamilies, QuasiQuotes, MultiParamTypeClasses, TemplateHaskell, OverloadedStrings #-}
module HelloWorld where
import Yesod

data HelloWorld = HelloWorld

mkYesod "HelloWorld" [parseRoutes|
/ HomeR GET
/page1 Page1R GET
/page2 Page2R GET
|]

instance Yesod HelloWorld where
    approot _ = ""

getHomeR = defaultLayout [whamlet|<a href="@{Page1R}">Go to page 1!|]
getPage1R = defaultLayout [whamlet|<a href="@{Page2R}">Go to page 2!|]
getPage2R = defaultLayout [whamlet|<a href="@{HomeR}">Go home!|]

withHelloWorld f = toWaiApp HelloWorld >>= f
