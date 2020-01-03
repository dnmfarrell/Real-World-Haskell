data BookInfo = Book Int String [String]
                deriving (Show)

myInfo = Book 9780135072455 "Algebra of Programming"
         ["Richard Bird", "Oege de Moor"]

data BookReview = BookReview BookInfo CustomerID String

type CustomerID = Int
type ReviewBody = String

data BetterReview = BetterReview BookInfo CustomerID ReviewBody

type BookRecord = (BookInfo, BookReview)


type CardNumber = String
type CardHolder = String
type Address = [String]

data BillingInfo = CreditCard CardNumber CardHolder Address
                 | CashOnDelivery
                 | Invoice CustomerID
                   deriving (Show)

bookID        (Book id title authors) = id
bookTitle     (Book id title authors) = title
bookAuthors   (Book id title authors) = authors
nicerID       (Book id _      _      ) = id
nicerTitle    (Book _  title  _      ) = title
nicerAuthors  (Book _  _      authors) = authors

data Customer = Customer {
  customerID          :: CustomerID,
  customerName        :: String,
  customerAddress     :: Address
} deriving (Show)

-- application syntax
customer1 = Customer 271828 "J.R. Hacker"
            ["255 Syntax Ct",
             "Milpitas, CA 95134",
             "USA"]

-- record syntax
customer2 = Customer {
              customerID = 27828,
              customerAddress = ["1048576 Disk Drive",
                                 "Milpitas, CA 95134",
                                 "USA"],
              customerName = "Jane Q. Citizen"
            }

