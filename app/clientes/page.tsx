import Shell from '@/components/Shell'
import { supabase } from '@/lib/supabase'

export default async function ClientesPage() {
  const { data: clientes } = await supabase
    .from('clients')
    .select('*')

  return (
    <Shell title="Clientes">
      <div className="card">
        <h2>Listado de Clientes</h2>

        <table style={{ width: '100%', marginTop: '20px' }}>
          <thead>
            <tr>
              <th>Empresa</th>
              <th>Contacto</th>
              <th>Email</th>
            </tr>
          </thead>

          <tbody>
            {clientes?.map((cliente: any) => (
              <tr key={cliente.id}>
                <td>{cliente.name}</td>
                <td>{cliente.contact_name}</td>
                <td>{cliente.contact_email}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </Shell>
  )
}
