USE  [AccountsPayableProject];
SELECT 
      va.VendorAccountName AS CompanyName,
	  va.VendorAddress,  
	  va.VendorContact,
	  BillingStatus.PurchaseSlip,
	  BillingStatus.PurchaseReceipt,
	  BillingStatus.InvoiceDate,
	  BillingStatus.InvoiceNumber,
      BillingStatus.ProductCategory,      
CASE 
      WHEN BillingStatus.PaymentAmount IS NOT NULL AND BillingStatus.VendorAccountBalance IS NOT NULL THEN 'Paid'
      ELSE'Unpaid'  
      END AS PaymentStatus
FROM [dbo].[VendorAccount] va
LEFT OUTER JOIN
     (SELECT pp.ProductCategory, pp.PurchaseSlip,pp.PurchaseReceipt, pp.QuantityOrdered, pp.TotalPrice, vi.InvoiceNumber, vi.PaymentAmount, vi.InvoiceDate, vi.VendorAccountBalance 
       FROM [dbo].[PurchaseProduct] pp                 
      INNER JOIN [dbo].[VendorInvoice] vi ON pp.InvoiceNumber = vi.InvoiceNumber
      ) AS BillingStatus
ON va.ProductCategory = BillingStatus.ProductCategory
WHERE
        va.VendorAccountName LIKE '%IpadAccessory%' ;