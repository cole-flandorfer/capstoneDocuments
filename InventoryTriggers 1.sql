DROP TRIGGER IF EXISTS `full-stack-ecommerce`.upd_check;

DELIMITER $$
CREATE TRIGGER upd_check BEFORE UPDATE ON product
FOR EACH ROW
BEGIN 
	IF NEW.units_in_stock <= 0 THEN
		SET NEW.units_in_stock =  100 + NEW.units_in_stock;
	END IF;
END $$


DROP TRIGGER IF EXISTS `full-stack-ecommerce`.QuantityUpdate;

DELIMITER |
CREATE TRIGGER  QuantityUpdate
AFTER INSERT
ON order_item 
FOR EACH ROW
	BEGIN
		UPDATE product
		SET product.units_in_stock = product.units_in_stock - New.quantity 
		WHERE product.id = New.product_id;
END |