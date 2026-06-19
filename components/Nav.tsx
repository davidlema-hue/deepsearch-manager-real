'use client'
import Link from 'next/link'
import { supabase } from '@/lib/supabase'
import { useRouter } from 'next/navigation'
const items=[['Dashboard','/dashboard'],['Clientes','/clientes'],['Usuarios','/usuarios'],['Roles','/roles'],['Tareas','/tareas'],['Cronopost','/cronopost'],['Tráfico Diseño','/trafico-diseno'],['Portal Cliente','/portal-cliente']]
export default function Nav(){const r=useRouter();return <aside className="w-64 min-h-screen bg-slate-950 text-white p-5 fixed"><h1 className="font-black text-xl mb-6">Deep Search</h1><nav className="grid gap-2">{items.map(([t,h])=><Link className="px-3 py-2 rounded-lg hover:bg-white/10 text-sm" href={h} key={h}>{t}</Link>)}<button className="mt-6 btn bg-white text-slate-950" onClick={async()=>{await supabase.auth.signOut();r.push('/login')}}>Salir</button></nav></aside>}
