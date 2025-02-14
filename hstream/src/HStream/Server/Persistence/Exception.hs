{-# LANGUAGE ExistentialQuantification #-}
module HStream.Server.Persistence.Exception where

import           Control.Exception (Exception (..), SomeException (..))
import           Data.Text         (Text)
import           Data.Typeable     (cast)

data PersistenceException = forall e . Exception e => PersistenceException e

instance Show PersistenceException where
  show (PersistenceException e) = show e

instance Exception PersistenceException

persistenceExceptionToException :: Exception e => e -> SomeException
persistenceExceptionToException = toException . PersistenceException

persistenceExceptionFromException :: Exception e => SomeException -> Maybe e
persistenceExceptionFromException x = do
  fromException @PersistenceException x >>= cast

data FailedToSetStatus = FailedToSetStatus
  deriving Show

instance Exception FailedToSetStatus where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

data FailedToSetHServer = FailedToSetHServer
  deriving Show

instance Exception FailedToSetHServer where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

data FailedToRecordInfo = FailedToRecordInfo
  deriving Show

instance Exception FailedToRecordInfo where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

data FailedToGet = FailedToGet
  deriving Show

instance Exception FailedToGet where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

data FailedToRemove = FailedToRemove
  deriving Show

instance Exception FailedToRemove where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

newtype FailedToDecode = FailedToDecode String
  deriving Show

instance Exception FailedToDecode where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

data QueryNotFound = QueryNotFound
  deriving Show

instance Exception QueryNotFound where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

data ConnectorNotFound = ConnectorNotFound
  deriving Show

instance Exception ConnectorNotFound where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

data QueryStillRunning = QueryStillRunning
  deriving Show

instance Exception QueryStillRunning where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

data ConnectorStillRunning = ConnectorStillRunning
  deriving Show

instance Exception ConnectorStillRunning where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

data UnexpectedZkEvent = UnexpectedZkEvent
  deriving Show

instance Exception UnexpectedZkEvent where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

newtype SubscriptionIdOccupied = SubscriptionIdOccupied Text
  deriving (Show)
instance Exception SubscriptionIdOccupied where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

newtype ShardReaderIdExists = ShardReaderIdExists Text
  deriving (Show)
instance Exception  ShardReaderIdExists where
  toException   = persistenceExceptionToException
  fromException = persistenceExceptionFromException

