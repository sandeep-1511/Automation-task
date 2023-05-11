# creating vpc peering
resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id = aws_vpc.appvpc.id
  peer_vpc_id = aws_vpc.dbvpc.id
  auto_accept = true
}
resource "aws_route" "vpc_appvpc_to_vpc_dbvpc" {
  route_table_id         = aws_route_table.route_table_public.id
  destination_cidr_block = aws_vpc.dbvpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}
resource "aws_route" "vpc_dbvpc_to_vpc_appvpc" {
  route_table_id         = aws_route_table.route_table_public01.id
  destination_cidr_block = aws_vpc.appvpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}
