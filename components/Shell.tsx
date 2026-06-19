import Nav from './Nav'
export default function Shell({children,title}:{children:React.ReactNode,title:string}){return <><Nav/><main className="ml-64 p-8"><h2 className="text-2xl font-black mb-5">{title}</h2>{children}</main></>}
