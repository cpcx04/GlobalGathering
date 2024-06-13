export interface ClienteResponse {
  id: string
  username: string
  email: string
  nombre: string
  role: string
  createdAt: any
  banned:boolean
}
export interface ClienteDto {
  username: string
  email: string
  fullName: string
  role: string
}