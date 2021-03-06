UPDATE PRODUCTS PRD
SET PRD.RECTANGLE = MDSYS.SDO_GEOMETRY(
    2003,  -- 2-dimensional polygon
    NULL,
    NULL,
    MDSYS.SDO_ELEM_INFO_ARRAY(1,1003,3), -- one rectangle (1003 = exterior)
    MDSYS.SDO_ORDINATE_ARRAY(0,0, 20,30) -- only 2 points needed to
          -- define rectangle (lower left and upper right) with
          -- Cartesian-coordinate data
  )
WHERE PRD.PRODUCTLINE = 'Classic Cars' or PRD.PRODUCTLINE = 'Motorcycles';

UPDATE PRODUCTS PRD
SET PRD.RECTANGLE = MDSYS.SDO_GEOMETRY(
    2003,  -- 2-dimensional polygon
    NULL,
    NULL,
    MDSYS.SDO_ELEM_INFO_ARRAY(1,1003,3), -- one rectangle (1003 = exterior)
    MDSYS.SDO_ORDINATE_ARRAY(0,0, 50,30) -- only 2 points needed to
          -- define rectangle (lower left and upper right) with
          -- Cartesian-coordinate data
  )
WHERE PRD.PRODUCTLINE = 'Planes' or PRD.PRODUCTLINE = 'Ships';

UPDATE PRODUCTS PRD
SET PRD.RECTANGLE = MDSYS.SDO_GEOMETRY(
    2003,  -- 2-dimensional polygon
    NULL,
    NULL,
    MDSYS.SDO_ELEM_INFO_ARRAY(1,1003,3), -- one rectangle (1003 = exterior)
    MDSYS.SDO_ORDINATE_ARRAY(0,0, 70,40) -- only 2 points needed to
          -- define rectangle (lower left and upper right) with
          -- Cartesian-coordinate data
  )
WHERE PRD.PRODUCTLINE = 'Trains' or PRD.PRODUCTLINE = 'Trucks and Buses';

UPDATE PRODUCTS PRD
SET PRD.RECTANGLE = MDSYS.SDO_GEOMETRY(
    2003,  -- 2-dimensional polygon
    NULL,
    NULL,
    MDSYS.SDO_ELEM_INFO_ARRAY(1,1003,3), -- one rectangle (1003 = exterior)
    MDSYS.SDO_ORDINATE_ARRAY(0,0, 70,50) -- only 2 points needed to
          -- define rectangle (lower left and upper right) with
          -- Cartesian-coordinate data
  )
WHERE PRD.PRODUCTLINE = 'Vintage Cars';
