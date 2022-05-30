/*Modify the path in quotes to match the 
location of the course data if necessary*/
*libname orion "s:\workshop";

proc format;
	value ordertypefmt 1="Retail"
		2="Phone"
		3="Internet";
	value colorfmt 0-4="lightred"
		13-high="lightgreen";
	picture PctFmt(round) low-high="009.9%";
run;

title "2014 Sales Report";

proc tabulate data=orion.orders format=comma8.;
	var Quantity;
	class Order_Type /	order=unformatted missing;
	class Order_Date /	order=unformatted missing;
	format Order_Type ordertypefmt.
		Order_Date 	monname.;

	table /* Row Dimension */
		Order_Date={label=" "} 
			all={label="Total"}*{style={font_size=12pt font_weight=bold font_style=italic}},
			/* Column Dimension */
		Order_Type={label=" "}*(
			Quantity={label=" "}*
			Sum={label="Items Ordered"} 
			Quantity={label=" "}*
			ColPctSum={label="% Items Ordered"}*f=pctfmt.*{style={background=colorfmt.}}) /
			style_precedence=row;
run;

title;

